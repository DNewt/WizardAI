variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "logging_bucket_name" {
  description = "The centralised S3 bucket set up to receive logs from other buckets"
  type        = string
}

variable "kms_key_id" {
  description = "The ID of the KMS key to use for encryption"
  type        = string
}
