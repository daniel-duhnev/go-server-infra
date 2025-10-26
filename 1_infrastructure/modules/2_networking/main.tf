# Main VPC resource
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.host_project_id
  auto_create_subnetworks = false
}

# Subnets and secondary ranges for each regional GKE cluster
resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets

  name          = "${var.network_name}-${each.key}"
  project       = var.host_project_id
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.vpc.self_link

  # Secondary ranges required by GKE - pods and services
  secondary_ip_range {
    range_name    = "pods-${each.key}"
    ip_cidr_range = each.value.pods_secondary_cidr
  }
  secondary_ip_range {
    range_name    = "services-${each.key}"
    ip_cidr_range = each.value.services_secondary_cidr
  }
}

# Service project GKE control plane and node VMs need permission to host project subnets.
# Investigate further how to best pass the values from all the projects involved.
# service_project_number is the numeric project number of the service project and NOT the project id.

# resource "google_compute_subnetwork_iam_member" "gke_network_user" {
#   project    = var.host_project_id         
#   region     = var.region
#   subnetwork = var.subnet_name
#   role       = "roles/compute.networkUser"
#   member     = "serviceAccount:service-${var.service_project_number}@container-engine-robot.iam.gserviceaccount.com"
# }
