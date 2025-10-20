# Module for project bootstrap if required

A light bootstrap module can be included if needed to:
- Create the GCP Project.
- Link it to the existing billing account.
- Enable the required Google APIs (GKE, Compute, IAM, Artifact Registry, Cloud Monitoring, Cloud Logging, Cloud DNS).
- Creating a GCS bucket + enabled versioning.
- Granting a Google Group or SA the Storage IAM roles required to read and write to terraform state file (roles/storage.objectAdmin + roles/storage.bucketAdmin to follow least privilage principle).

Option 1:
- Run terraform project bootstrap locally with a local backend with the default terraform.tfstate file.
- Reconfigure the Terraform backend to point at that bucket, then run init + migrate state to move local state to remote.

Option 2 - no Terraform:
- Write and execute a script manually.
- Simple with no special tooling but requires manual step.
