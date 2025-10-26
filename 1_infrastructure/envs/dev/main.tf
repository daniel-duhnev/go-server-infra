# Networking - host project
module "network" {
  source = "../../modules/2_networking"

  host_project_id              = var.project_id
  network_name                 = "${var.environment}-network"
  subnets                      = var.subnets
  lb_ip_name                   = "${var.environment}-lb-ip"
  dns_zone_name                = var.dns_zone_name
  dns_domain                   = var.dns_domain
  lb_healthcheck_source_ranges = var.lb_healthcheck_source_ranges

  providers = {
    google = google.host
  }
}

# GKE Active cluster
module "gke_active" {
  source = "../../modules/3_gke"

  providers = {
    google = google.svc_active
  }

  project           = var.service_project_active_id
  network_self_link = module.network.vpc_self_link

  clusters = {
    active = {
      name                          = "${var.environment}-gke-active"
      region                        = var.subnets[var.active_subnet_key].region
      subnetwork_self_link          = module.network.subnet_self_links[var.active_subnet_key]
      pods_secondary_range_name     = module.network.pods_secondary_range_names[var.active_subnet_key]
      services_secondary_range_name = module.network.services_secondary_range_names[var.active_subnet_key]

      node_pool = {
        name               = "default-pool"
        machine_type       = "e2-medium"
        initial_node_count = 1
        min_count          = 1
        max_count          = 3
        preemptible        = false
        disk_size_gb       = 50
      }
    }
  }
}

# GKE Passive cluster
module "gke_passive" {
  source = "../../modules/3_gke"

  providers = {
    google = google.svc_passive
  }

  project           = var.service_project_passive_id
  network_self_link = module.network.vpc_self_link

  clusters = {
    passive = {
      name                          = "${var.environment}-gke-passive"
      region                        = var.subnets[var.passive_subnet_key].region
      subnetwork_self_link          = module.network.subnet_self_links[var.passive_subnet_key]
      pods_secondary_range_name     = module.network.pods_secondary_range_names[var.passive_subnet_key]
      services_secondary_range_name = module.network.services_secondary_range_names[var.passive_subnet_key]

      node_pool = {
        name               = "default-pool"
        machine_type       = "e2-small"
        initial_node_count = 1
        min_count          = 1 # keep warm for fast failover
        max_count          = 3
        preemptible        = false
        disk_size_gb       = 50
      }
    }
  }
}
