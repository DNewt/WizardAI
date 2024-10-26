locals {
  full_bucket_name = "wizardai-${var.bucket_name}-${var.environment}"

  strict_tags = {
    Name        = local.full_bucket_name
    Environment = var.environment
    TeamName    = var.team_name
    TeamEmail   = var.team_email
  }

  combined_tags = merge(var.custom_tags, local.strict_tags)
}
