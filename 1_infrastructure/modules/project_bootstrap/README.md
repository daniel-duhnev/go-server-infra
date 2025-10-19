# Include terraform module for project bootstrap if required

A light bootstrap module can be included if needed in order to:
- Create the GCP Project.
- Link it to the existing billing account.
- Enable the required Google APIs (GKE, Compute, IAM, Artifact Registry, Cloud Monitoring, Cloud Logging, Cloud DNS).