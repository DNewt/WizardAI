# Instructions (Module README is in the module folder)

Follow the steps below to test the wizardai_aws_s3_bucket module.

## Prerequisites

- Add the name of the target logging bucket to the .env file.
- Add the ID of the KMS key to the .env file.
- Add the AWS credentials to the .env file.
- Docker installed for testing (to ensure a consistent environment).

There is a presumption that the logging bucket and KMS key already exist and are managed by another team. Logging and encryption are enforced by the module, so the module will not work without these prerequisites.

## Steps

1. Clone the repository:

```bash
git clone https://github.com/DNewt/WizardAI.git
cd WizardAI
```

2. Run the Terraform commands:

```bash
docker compose run --rm --entrypoint sh terraform -c "cd example && terraform init && terraform plan"
```

```bash
docker compose run --rm --entrypoint sh terraform -c "cd example && terraform init && terraform apply --auto-approve"
```

OR

Run the Terratest test:

```bash
docker compose run --rm gotest
```
