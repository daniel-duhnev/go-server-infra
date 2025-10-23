# Allow internal VPC traffic
resource "google_compute_firewall" "allow-internal" {
  name    = "${var.network_name}-allow-internal"
  project = var.project
  network = google_compute_network.vpc.self_link

  # Allow all protocols internally
  allow {
    protocol = "all"
  }

  # Limit scope to the subnet CIDRs created by this module
  source_ranges = [for s in var.subnets : s.cidr]
  direction     = "INGRESS"
  # priority integer from 0 to 65535, lower number = higher priority, default 1000
  # see google doc for more info: https://cloud.google.com/firewall/docs/firewalls#priority_order_for_firewall_rules
  priority      = 1000
}

# Allow GCP load balancer health checks to reach nodes
resource "google_compute_firewall" "allow-lb-healthchecks" {
  name    = "${var.network_name}-allow-lb-healthchecks"
  project = var.project
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }

  source_ranges = var.lb_healthcheck_source_ranges
  direction     = "INGRESS"
  priority      = 1000
}

# Implicit egress allow rule exists to allow all outbound traffic
# See: https://cloud.google.com/firewall/docs/firewalls#default_firewall_rules
# Think about how you can apply least privilege principle to restrict outbound traffic


