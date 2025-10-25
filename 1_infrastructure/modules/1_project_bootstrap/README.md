# Module for project bootstrap if required

A light bootstrap module can be included if needed to:
- Prepare GCP projects - a management (host) project and 2 service projects where GKE clusters in different regions will be created.
- Link each target project to the existing billing account.
- Enable the required Google APIs in the appropriate projects (e.g. GKE, Compute, IAM, Artifact Registry, Cloud Monitoring, Cloud Logging, Cloud DNS).
- Create a GCS bucket for Terraform state and enable versioning.
- Grant a Google Group or Service Account the Storage IAM roles required to read/write Terraform state (follow least-privilege such as roles/storage.objectAdmin + roles/storage.bucketAdmin).

Option 1:
- Run terraform project bootstrap locally with a local backend with the default terraform.tfstate file.
- Reconfigure the Terraform backend to point at that bucket, then run init + migrate state to move local state to remote.

Option 2 - no Terraform:
- Write and execute a script manually.
- Simple with no special tooling but requires manual step.
