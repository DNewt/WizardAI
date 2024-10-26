variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 3 && length(var.bucket_name) < 40
    error_message = "The bucket name has the prefix 'wizardai-', suffix <environment> and can't be longer than 63 characters"
  }
}

variable "custom_tags" {
  description = "Additional tags provided by the user"
  type        = map(string)
  default     = {}
}

variable "enable_object_lock" {
  description = "Enable object lock for the bucket"
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment this module is deployed into (e.g., development, staging, production)"
  type        = string

  validation {
    condition     = var.environment == "development" || var.environment == "staging" || var.environment == "production"
    error_message = "Environment must be one of: development, staging, production."
  }
}

variable "expiration_days" {
  description = "The number of days to expire objects in the bucket"
  type        = number
  default     = 365
}

variable "enable_expiration" {
  description = "Enable expiration of objects in the bucket"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ID of the KMS key to use for encryption"
  type        = string

  validation {
    condition     = length(var.kms_key_id) > 0
    error_message = "To meet WizardAIs security best practices, you must provide a KMS Key ID for encryption."
  }
}

variable "logging_bucket_name" {
  description = "The centralised S3 bucket set up to receive logs from other buckets"
  type        = string

  validation {
    condition     = length(var.logging_bucket_name) > 0
    error_message = "To meet WizardAIs security best practices, you must reference the centralised logging bucket."
  }
}

variable "retention_period" {
  description = "The retention period for objects in the bucket (days) - only used if object lock is enabled"
  type        = number
  default     = 7
}

variable "team_email" {
  description = "Contact details for the team that owns this bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$", var.team_email))
    error_message = "The team email must be a valid email address."
  }
}

variable "team_name" {
  description = "The name of the team that owns this bucket"
  type        = string

  validation {
    condition     = length(var.team_name) > 0
    error_message = "The team name must not be empty"
  }
}
