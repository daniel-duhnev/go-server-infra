output "cluster_names" {
  description = "Map of cluster keys to created cluster names."
  value       = { for k, c in google_container_cluster.cluster : k => c.name }
}