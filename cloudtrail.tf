resource "aws_cloudtrail" "tf_cloudtrail" {
  name                          = "terraform-cloudtrail"
  s3_bucket_name                = var.bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::${var.bucket_name}/"]
    }
  }

  tags = {
    Name        = "Terraform CloudTrail"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "terraform-aws-project"
  }
}
