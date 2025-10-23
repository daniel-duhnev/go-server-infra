# VPC
output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

# Map of subnet name  keyed  self_links keyed by the same keys as var.subnets
output "subnet_self_links" {
  value = { for k, s in google_compute_subnetwork.subnet : k => s.self_link }
}

# Pod secondary range names
output "pods_secondary_range_names" {
  value = { for k, s in google_compute_subnetwork.subnet : k => "pods-${k}" }
}

# Service secondary range names
output "services_secondary_range_names" {
  value = { for k, s in google_compute_subnetwork.subnet : k => "services-${k}" }
}

# reserved global IP
output "lb_global_ip" {
  value = google_compute_global_address.lb_ip.address
}

# DNS zone info
output "dns_zone_name" {
  value = google_dns_managed_zone.public_zone[0].name
}
