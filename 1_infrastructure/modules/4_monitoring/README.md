# Monitoring stack

## Three options to consider:

- Regional Prometheus - one per GKE cluster in each service project
  - Pro: Isolation and low-latency metrics for each cluster — no cross-region dependency.
  - Con: Operational overhead — multiple Prometheus instances to manage and aggregate.

- Central Prometheus - single instance VM or dedicated GKE in host project
  - Centralize scraping and alerting in one Prometheus.
  - Pro: Centralized metrics, alerts, and queries across clusters.
  - Con: Single point of failure and more complex to setup.

- Google Cloud Managed Service for Prometheus - managed Prometheus ingestion, storage and alerts
  - Pro: Less operational burden. Scalable and integrated with GCP tooling.
  - Con: Vendor lock-in. Higher cost compared to self-hosted option.

## Proposed solution

Provide a simple monitoring approach for two-region GKE - local per-cluster monitoring stack and metrics for autoscaling.

## Proposal

Install a lightweight Prometheus and Grafana stack in each cluster and use prometheus-adapter to expose metrics to HPA.

## Key components
- kube-prometheus-stack (Prometheus Operator, Prometheus, Alertmanager, Grafana) — per cluster.
- prometheus-adapter — exposes Prometheus metrics via the Kubernetes Custom Metrics API for HPA.
- ServiceMonitor and PodMonitor — instruct Prometheus what to scrape.
- HPA (v2) — uses adapter-provided metrics to scale pods.
- Cluster Autoscaler — node autoscaling enabled on node pools.

Why this approach
- Pro: Low-latency and fast autoscalling with local metrics. Easy to deploy per cluster and  ds cross-region dependencies for autoscaling.
- Con: Some operational overhead - Consider using a managed service if budget allows and bandwidth is limited.

## Prerequisites
- kubectl configured for the target cluster.
- Helm v3 to install Helm charts.
- GKE node pools with autoscaling enabled.
- Permissions to create CRDs, ClusterRoles, and cluster-level resources.

