# Configuração de Rede para Cloud SQL
resource "google_compute_global_address" "private_ip_address" {

  name                      = "private-ip-address"
  purpose                   = "VPC_PEERING"
  address_type              = "INTERNAL"
  prefix_length             = 16
  network                   = "projects/${var.project_id}/global/networks/default"
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                   = "default"
  service                   = "servicenetworking.googleapis.com"
  reserved_peering_ranges   = [google_compute_global_address.private_ip_address.name]

  depends_on                = [google_compute_global_address.private_ip_address]
}

# Router para saída do Cluster
resource "google_compute_address" "gke-external" {
  name   = "gke-external"
  region = var.region
}

resource "google_compute_router" "gke-router" {
  name    = "gke-routers"
  project = var.project_id
  region  = var.region
  network = "projects/${var.project_id}/global/networks/default"
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
  }
}

resource "google_compute_router_nat" "gke-nat" {
  name                               = "gke-nat"
  project                            = var.project_id
  router                             = google_compute_router.gke-router.name
  region                             = google_compute_router.gke-router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.gke-external.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                   = 64

  log_config {
    enable = false
    filter = "ALL"
  }

  depends_on = [
    google_compute_router.gke-router
  ]
}
