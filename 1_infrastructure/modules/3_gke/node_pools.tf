resource "google_container_node_pool" "node_pool" {
  for_each = var.clusters

  name               = each.value.node_pool.name
  project            = var.project
  cluster            = each.value.name
  location           = each.value.region
  initial_node_count = each.value.node_pool.initial_node_count

  node_config {
    machine_type = each.value.node_pool.machine_type
    disk_size_gb = each.value.node_pool.disk_size_gb
    preemptible  = each.value.node_pool.preemptible
  }

  autoscaling {
    min_node_count = each.value.node_pool.min_count
    max_node_count = each.value.node_pool.max_count
  }
}