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
