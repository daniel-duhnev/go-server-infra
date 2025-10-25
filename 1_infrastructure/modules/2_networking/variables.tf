variable "host_project_id" {
  type        = string
  description = "GCP project id where VPC will be created."
}

variable "network_name" {
  type        = string
  description = "Name of the VPC to create."
}

# Required variables for VPC subnet for GKE
variable "subnets" {
  type = map(object({
    region                 = string
    # assign internal IP addresses for gke nodes
    cidr                   = string
    # assign internal IP addresses for gke pods
    pods_secondary_cidr    = string
    # assign internal IP addresses for gke services 
    services_secondary_cidr= string
  }))
  description = <<EOT
    Map of subnet definitions keyed by name used within org.
    Example:
    {
    eu-west1 = { region="europe-west1", cidr="10.10.0.0/20", pods_secondary_cidr="10.20.0.0/16", services_secondary_cidr="10.21.0.0/20" }
    }
    EOT
}

variable "lb_ip_name" {
  type        = string
  description = "Name for the reserved global IP for the global HTTPS LB"
}

variable "dns_zone_name" {
  type        = string
  description = "Short name for the Cloud DNS managed zone (e.g. my-service-zone)"
  default     = null
}

variable "dns_domain" {
  type        = string
  description = "Public DNS domain for the service. Include trailing dot in the end."
  default     = null
}

# Healthcheck source ranges for GCP load balancer probes
variable "lb_healthcheck_source_ranges" {
  type = list(string)
  default = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
  description = "Source ranges for GCP load balancer health checks. See https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-range"
}
