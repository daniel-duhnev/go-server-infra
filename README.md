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

## Solution high level overview

1. Infrastructure

Provision network + two regonal GKE clusters using a Shared VPC pattern. Networking components deployed in a host project, while GKE clusters run in separate service projects attached to the host VPC. Uses a single Global HTTPS Load Balancer to expose web server from a single endpoint.

### Key components
- Networking module (modules/2_networking): creates host VPC, per-region subnets with Pod/Service secondary ranges, firewall rules allowing LB health checks, reserved global IP and DNS zone.
- GKE module (modules/3_gke): creates one regional GKE cluster per var.clusters entry, explicit node pools, Workload Identity enabled, and uses the host subnets/secondary ranges.

- (Planned) Ingress module: wires NEGs from clusters to a single global BackendService + frontend IP (GCLB) — created after clusters and ingress controllers exist.

- (Planned) Monitoring module: per-cluster Prometheus + Grafana + prometheus-adapter to support custom-metric HPA.