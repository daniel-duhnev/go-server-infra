# Reserve a global IP for the LB frontend
resource "google_compute_global_address" "lb_ip" {
  name    = var.lb_ip_name
  project = var.host_project_id
  # ensure publicly routable IP
  address_type = "EXTERNAL"
}

# Public DNS zone and record pointing at the reserved global IP.
resource "google_dns_managed_zone" "public_zone" {
  name        = var.dns_zone_name
  dns_name    = var.dns_domain
  project     = var.host_project_id
  description = "Public zone for application domain."
}

resource "google_dns_record_set" "lb_a_record" {
  count = length(google_dns_managed_zone.public_zone) > 0 ? 1 : 0

  name         = var.dns_domain
  managed_zone = google_dns_managed_zone.public_zone.name
  # address record needed to map domain to IP
  type = "A"
  ttl  = 300
  # resource record data - include the IP address to be mapped
  rrdatas = [google_compute_global_address.lb_ip.address]
  project = var.host_project_id
}
