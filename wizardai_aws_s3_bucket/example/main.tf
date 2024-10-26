module "wizardai_aws_s3_bucket_example" {
  source = "../"

  bucket_name         = "bucket-example"
  environment         = "development"
  kms_key_id          = var.kms_key_id
  team_name           = "WizardAIDevOps"
  team_email          = "devops@wizardai.com"
  logging_bucket_name = var.logging_bucket_name

  custom_tags = {
    "CustomTag" = "Test"
  }
}
