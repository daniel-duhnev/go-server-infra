# How to run Terraform locally

## Prerequisites
- Installed gcloud and Terraform.
- Have permissions on host and service projects.

## Authenticate
- Use `gcloud auth application-default login`

## Prepare variables locally - do not commit
- See `\terraform.tfvars.example` for an example

## Prepare backend config
- Pass `-backend-config` at terraform init.
- Example `backend.hcl` if file pass preferred:
```
bucket = "terraform-state-bucket-123"
prefix = "dev/1_infrastructure/2_networking"
```

## Run Terraform from env root:
- Example flow:
```
cd 1_infrastructure\envs\dev
terraform init -backend-config=backend.hcl
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```
