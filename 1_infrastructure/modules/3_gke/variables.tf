variable "cluster_name" {
  description = "GKE cluster name."
  type        = string

# add validation to ensure the cluster name is a valid based on gcp documentation requirements. For example:
  validation {
    condition     = length(var.cluster_name) > 0 && length(var.cluster_name) <= 63
    error_message = "cluster_name must be a non-empty. Max 63 chars."
  }
}