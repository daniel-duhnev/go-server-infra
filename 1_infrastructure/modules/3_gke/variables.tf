variable "project" {
  type        = string
  description = "GCP project id where clusters will be created."
}

variable "network_self_link" {
  type        = string
  description = "Self link of the VPC network."
}

# clusters map keyed by org name (eg 'europe')
variable "clusters" {
  type = map(object({
    name                         = string  # cluster name
    region                       = string  # GCP region (eg europe-west1)
    subnetwork_self_link         = string  # module.network.subnet_self_links[key]
    pods_secondary_range_name    = string  # module.network.pods_secondary_range_names[key]
    services_secondary_range_name= string  # module.network.services_secondary_range_names[key]

    # node pool config for this cluster
    node_pool = object({
      name              = string
      machine_type      = string
      initial_node_count= number
      min_count         = number
      max_count         = number
      preemptible       = bool
      disk_size_gb      = number
    })
  }))

  description = <<EOT
    Map of clusters to create keyed by name used within org.
    Must include cluster name, region, subnetwork_self_link, and pod and service secondary range names.
    EOT
}
