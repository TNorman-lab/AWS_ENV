variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-prod-bucket"
}
#new variable
variable "bucket_description" {
  description = "A description for the S3 bucket"
  type        = string
  default     = "my terraform prod bucket"
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "production"
}

variable "k8s_host" {
  description = "Kubernetes API server endpoint"
  type        = string
}

variable "k8s_ca_cert" {
  description = "Base64 encoded Kubernetes cluster CA certificate"
  type        = string
}

variable "k8s_token" {
  description = "Kubernetes service account token"
  type        = string
  sensitive   = true
}