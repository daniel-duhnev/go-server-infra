# Go Server Infra Proposal
IaC proposal for deploying a highly available Golang web server on GCP using GKE and Terraform.

## Requirements
### 1. Infrastructure
- Diagram of architecture in GCP to deploy server with high availability
- Terraform code (IaC) - should be modular and reusable
- Use of Kubernetes (GKE)
- Auto-scaling policies based on custom metrics
- multi-region failover architecture
- monitoring stack (Prometheus/Grafana)

### 2. Application
- Diagram of the CI/CD proposal
- Tool to automate the Docker build and deploy of server
- Implement canary deployments
- Add automated rollback strategies
- Serve traffic from port 443 with a self-signed certificate

### 3. Security
- Provide an explanation about the security of the tech stack
- Zero Trust architecture
- Add a Vault for secrets management
- Implement Pod Security Policies
- Add WAF configuration
- Implement an audit logging system

## Assumptions and prerequisites
This proposal assumes the following higher-level infrastructure and configuration already exist:
- A Cloud Billing Account at the Organization level.
- A GCP Project which is linked to the existing billing account.
- The required Google APIs are enabled - GKE, Compute, IAM, Artifact Registry, Cloud Monitoring, Cloud Logging, Cloud DNS.
- GCS Bucket exists for storing terraform state.
- IAM is setup to run terraform - either Google Group with least privilage IAM roles or better and more secure - dedicated Terraform service account + impersonate that SA when running Terraform (SA required for any CI/CD automation solution).

## Overview of solution

### Networking
Objects to create:
- VPC - network boundary for clusters.
- Two regional subnets - one per region for multi-region failover architecture.
- Secondary alias IP ranges per subnet for pods and services.
- Firewall rule to permit GCP Health Checks - use publicly known source ranges found on https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-range
- Reserved global static IP for the GCLB frontend for a single public IP.
- Cloud DNS public zone record pointing the hostname to the reserved IP.

Module output:
- Outputs from the networking module that the GKE module consumes: subnet self_links, secondary range names, reserved IP value, and firewall names.

### GKE