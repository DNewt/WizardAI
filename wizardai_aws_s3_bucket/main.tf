resource "aws_s3_bucket" "this" {
  bucket              = "wizardai-${var.bucket_name}-${var.environment}"
  object_lock_enabled = var.enable_object_lock ? true : false

  tags = local.combined_tags
}

# Policy to enforce HTTPS (encryption in transit) and deny unencrypted uploads
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Server Side Encryption - Enforce AWS:KMS with a customer managed key
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
  }
}

# Enable versioning for objects in the bucket
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable logging for the bucket
resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.this.id

  target_bucket = data.aws_s3_bucket.logging_bucket.id
  target_prefix = aws_s3_bucket.this.id
}

# Enable data retention
resource "aws_s3_bucket_object_lock_configuration" "this" {
  count  = var.enable_object_lock ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = var.retention_period
    }
  }
}

# Enable expiry
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_expiration ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = var.expiration_days
    }
  }
}
