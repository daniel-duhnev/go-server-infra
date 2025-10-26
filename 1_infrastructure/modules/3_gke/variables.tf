variable "project" {
  type        = string
  description = "GCP project id where clusters will be created."
}

variable "network_self_link" {
  type        = string
  description = "Self link of the VPC network."
}

# clusters map keyed by name used within org
variable "clusters" {
  type = map(object({
    name                         = string  
    region                       = string  
    subnetwork_self_link         = string  
    pods_secondary_range_name    = string  
    services_secondary_range_name= string  

    # node pool config
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
