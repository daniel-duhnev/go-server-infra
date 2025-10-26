terraform {
  required_version = "~> 1.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.8"
    }
  }
}

# Provider for host project
provider "google" {
  alias   = "host"
  project = var.project_id
}

# Provider for active service project
provider "google" {
  alias   = "svc_active"
  project = var.service_project_active_id
}

# Provider for passive service project
provider "google" {
  alias   = "svc_passive"
  project = var.service_project_passive_id
}
