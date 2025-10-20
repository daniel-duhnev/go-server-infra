# Go Server Infra Proposal
IaC proposal for deploying a highly available Golang web server on GCP using GKE and Terraform.

## Assumptions and prerequisites
This proposal assumes the following higher-level infrastructure and configuration already exist:
- A Cloud Billing Account at the Organization level.
- A GCP Project which is linked to the existing billing account.
- The required Google APIs are enabled - GKE, Compute, IAM, Artifact Registry, Cloud Monitoring, Cloud Logging, Cloud DNS.
- GCS Bucket exists for storing terraform state.
- IAM is setup to run terraform - either Google Group with least privilage IAM roles or better and more secure - dedicated Terraform service account + impersonate that SA when running Terraform (SA required for any CI/CD automation solution).
