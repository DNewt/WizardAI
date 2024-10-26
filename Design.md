# Design Considerations

I wanted to keep the module simple so it could be widely used across WizardAI and meet 80% of the internal customers needs. This was a trade off between ease of use and flexibility. More advanced teams might prefer a module with more configuration options and less strict enforcement of settings. Adding more configuration options for these niche teams quickly adds complexity and makes the module overwhelming for the majority of users.

## Presumptions

- A centralised logging bucket exists
- A centralised S3 backup plan exists using AWS Backup
- A KMS key exists for encryption at rest
- A Service Control Policy to enforce encryption and block public access for S3 is NOT in place
- AWS Config is NOT enabled to monitor S3 bucket configurations (and trigger remediation actions)

These presumptions mean:

- Logging is enabled by default and a data source is used to reference the existing logging bucket
- Versioning must be enabled for the S3 backup plan to work
- The user must provide the KMS key ID to encrypt the S3 bucket
- A bucket policy is created alongside the S3 bucket to enforce encryption in transit
- Blocking public access is enabled via Terraform

## Simplifications

These may need to be revisited if the module needs to cover more use cases:

- Expiry of objects disabled by default to avoid accidental data loss
- Force destroy left at the default (false) to avoid accidental data loss
- No CORS configuration, unsure if engineering teams require this feature
- No transitioning of objects to different storage classes to avoid complexity
- No replication due to presuming backup plan is in place, cross region replication may be required for latency improvements
