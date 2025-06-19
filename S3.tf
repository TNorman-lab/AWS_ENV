resource "aws_s3_bucket" "my-terraform-prod-bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Description = var.bucket_description
    Environment = var.environment
    Project     = "terraform-aws-project" # Name your project
    ManagedBy   = "Terraform"
  }
}

# Enable versioning for data protection (Optional)
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.my-terraform-prod-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
