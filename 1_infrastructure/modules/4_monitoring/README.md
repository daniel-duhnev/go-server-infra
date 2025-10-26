# Monitoring stack

Three options to consider:

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
