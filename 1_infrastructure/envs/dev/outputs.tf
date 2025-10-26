output "vpc_self_link" {
  value = module.network.vpc_self_link
}

output "subnet_self_links" {
  value = module.network.subnet_self_links
}

output "pods_secondary_range_names" {
  value = module.network.pods_secondary_range_names
}

output "services_secondary_range_names" {
  value = module.network.services_secondary_range_names
}

output "active_cluster_name" {
  value = module.gke_active.cluster_names["active"]
}

output "passive_cluster_name" {
  value = module.gke_passive.cluster_names["passive"]
}

output "lb_global_ip" {
  value = module.network.lb_global_ip
}
