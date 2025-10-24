terraform {
  # use pessimistic version constraints to prevent automatic upgrades to new major versions
  required_version = "~> 1.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.8"
    }
  }
}
