resource "google_container_node_pool" "on-demand-pool" {
    name               = "on-demand-pool"
    cluster            = var.cluster_name
    initial_node_count = 1

    node_config {
        machine_type = "e2-medium"
    }
}