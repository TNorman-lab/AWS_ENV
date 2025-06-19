import boto3
from json import loads, dump
import logging
from botocore.exceptions import ClientError

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def check_bucket_public_access(bucket_name, s3_client):
    """Check if an S3 bucket is publicly accessible via ACL or policy."""
    try:
        # Check bucket ACL
        acl = s3_client.get_bucket_acl(Bucket=bucket_name)
        for grant in acl['Grants']:
            grantee = grant.get('Grantee', {})
            if grantee.get('Type') == 'Group' and 'AllUsers' in grantee.get('URI', ''):
                return True, "Public access via ACL: AllUsers"

        # Check bucket policy
        try:
            policy = s3_client.get_bucket_policy(Bucket=bucket_name)
            policy_json = loads(policy['Policy'])
            for statement in policy_json.get('Statement', []):
                if (statement.get('Effect') == 'Allow' and
                        statement.get('Principal') == '*' or
                        'AWS' in statement.get('Principal', {}) and statement['Principal']['AWS'] == '*'):
                    return True, "Public access via policy: Allow *"
        except ClientError as e:
            if e.response['Error']['Code'] == 'NoSuchBucketPolicy':
                pass  # No policy exists
            else:
                raise e

        return False, "No public access detected"
    except ClientError as e:
        logger.error(f"Error checking bucket {bucket_name}: {e}")
        return False, f"Error: {str(e)}"

def scan_s3_buckets():
    """Scan all S3 buckets and generate a security report."""
    s3_client = boto3.client('s3')
    report = []

    try:
        response = s3_client.list_buckets()
        for bucket in response['Buckets']:
            bucket_name = bucket['Name']
            logger.info(f"Scanning bucket: {bucket_name}")
            is_public, details = check_bucket_public_access(bucket_name, s3_client)
            report.append({
                'bucket_name': bucket_name,
                'is_public': is_public,
                'details': details
            })

        # Save report to JSON file
        with open('s3_security_report.json', 'w') as f:
            dump(report, f, indent=2)
        logger.info("Report generated: s3_security_report.json")
        return report
    except ClientError as e:
        logger.error(f"Error listing buckets: {e}")
        return []

if __name__ == "__main__":
    scan_s3_buckets()