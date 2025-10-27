# Quick example of artifact registry deployment (non-functional and non-tested)

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the repository (e.g., europe-west1)"
  type        = string
}

# Ensure the Artifact Registry API is Enabled
resource "google_project_service" "artifact_registry_api" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false 
}

# Create the Docker Repository
resource "google_artifact_registry_repository" "docker_repo" {
  project      = var.project_id
  repository_id = "app-container-repo"
  description  = "Docker repository for application images"
  format       = "DOCKER"
  location     = var.gcp_region 
  depends_on   = [google_project_service.artifact_registry_api]
}

# Output the Repository URL
output "artifact_registry_url" {
  description = "The full URL for pushing Docker images."
  value       = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}"
}