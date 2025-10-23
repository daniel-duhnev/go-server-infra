terraform {
  # use pessimistic version constraints to prevent automatic upgrades to new major versions
  required_version = "~> 1.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.8"
    }
  }

    backend "gcs" {
        bucket  = var.gcs_bucket_name
        prefix  = "terraform/state/1_infrastructure/modules/2_networking"
        project = var.project_id
    }
}
