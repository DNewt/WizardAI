# Basic Usage Example

This example sets up a WizardAI AWS S3 bucket with the default settings.

The logging_bucket_name and kms_key_id are required to be set as it is presumed that the logging bucket and KMS key exist and are managed by another team.

## Usage

```bash
export TF_VAR_logging_bucket_name="<logging_bucket_name>"
export TF_VAR_kms_key_id="<kms_key_id>"
terraform init
terraform apply
```
