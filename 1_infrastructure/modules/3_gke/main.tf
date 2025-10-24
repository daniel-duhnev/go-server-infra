# Create a regional GKE cluster for each entry in var.clusters
resource "google_container_cluster" "cluster" {
  for_each = var.clusters

  name     = each.value.name
  project  = var.project
  location = each.value.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_self_link
  subnetwork = each.value.subnetwork_self_link

  # Use VPC-native IP aliasing with secondary ranges
  ip_allocation_policy {
    cluster_secondary_range_name  = each.value.pods_secondary_range_name
    services_secondary_range_name = each.value.services_secondary_range_name
  }

  # Enable Workload Identity
  # Highly recommended approach to securely access GCP services from apps running in GKE
  # Doc: https://cloud.google.com/kubernetes-engine/docs/concepts/workload-identity#what_is
  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  # Enable basic monitoring and logging integration
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}
