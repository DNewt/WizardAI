# wizardai_aws_s3_bucket

This module is used to create and manage an S3 bucket following Wizard.Ai's best practices.

## Features

Security:

- Encryption at rest
- Encryption in transit
- Bucket policies
- Block public access
- Versioning enabled
- Tagging for cost allocation and tracking
- Logging enabled
- Lifecycle policies (optional expiry)
- Retention period (optional object lock)

## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 5.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 5.0  |

## Resources

| Name                                                                                                                                                                                  | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource    |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration)                           | resource    |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging)                                                           | resource    |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration)                       | resource    |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                                                             | resource    |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                                   | resource    |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource    |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource    |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                    | data source |
| [aws_s3_bucket.logging_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket)                                                              | data source |

## Inputs

| Name                                                                                       | Description                                                                                 | Type          | Default | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name)                         | The name of the S3 bucket (wizardai-<bucket_name>-environment)                              | `string`      | n/a     |   yes    |
| <a name="input_custom_tags"></a> [custom_tags](#input_custom_tags)                         | Additional tags provided by the user (Strict tags overwrite if same name (see below))       | `map(string)` | `{}`    |    no    |
| <a name="input_enable_expiration"></a> [enable_expiration](#input_enable_expiration)       | Enable expiration of objects in the bucket                                                  | `bool`        | `false` |    no    |
| <a name="input_enable_object_lock"></a> [enable_object_lock](#input_enable_object_lock)    | Enable object lock for the bucket                                                           | `bool`        | `false` |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                         | The environment this module is deployed into (e.g., development, staging, production)       | `string`      | n/a     |   yes    |
| <a name="input_expiration_days"></a> [expiration_days](#input_expiration_days)             | The number of days to expire objects in the bucket                                          | `number`      | `365`   |    no    |
| <a name="input_kms_key_id"></a> [kms_key_id](#input_kms_key_id)                            | The ID of the KMS key to use for encryption                                                 | `string`      | n/a     |   yes    |
| <a name="input_logging_bucket_name"></a> [logging_bucket_name](#input_logging_bucket_name) | The centralised S3 bucket set up to receive logs from other buckets                         | `string`      | n/a     |   yes    |
| <a name="input_retention_period"></a> [retention_period](#input_retention_period)          | The retention period for objects in the bucket (days) - only used if object lock is enabled | `number`      | `7`     |    no    |
| <a name="input_team_email"></a> [team_email](#input_team_email)                            | Contact details for the team that owns this bucket                                          | `string`      | n/a     |   yes    |
| <a name="input_team_name"></a> [team_name](#input_team_name)                               | The name of the team that owns this bucket                                                  | `string`      | n/a     |   yes    |

## Outputs

| Name                                                                          | Description                         |
| ----------------------------------------------------------------------------- | ----------------------------------- |
| <a name="output_bucket_arn"></a> [bucket_arn](#output_bucket_arn)             | The ARN of the S3 bucket            |
| <a name="output_bucket_id"></a> [bucket_id](#output_bucket_id)                | The ID of the S3 bucket             |
| <a name="output_logging_bucket"></a> [logging_bucket](#output_logging_bucket) | The logging bucket of the S3 bucket |
| <a name="output_logging_prefix"></a> [logging_prefix](#output_logging_prefix) | The logging prefix of the S3 bucket |

## Strict tags

These tags are enforced by the module and will overwrite any tags with the same name provided by the user:

- `Name`: The name of the S3 bucket (wizardai-<var.bucket_name>-environment)
- `Environment`: var.environment
- `TeamName`: var.team_name
- `TeamEmail`: var.team_email
