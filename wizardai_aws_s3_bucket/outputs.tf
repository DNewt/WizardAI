output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "logging_bucket" {
  description = "The logging bucket of the S3 bucket"
  value       = aws_s3_bucket_logging.this.target_bucket
}

output "logging_prefix" {
  description = "The logging prefix of the S3 bucket"
  value       = aws_s3_bucket_logging.this.target_prefix
}
