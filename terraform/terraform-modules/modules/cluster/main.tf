resource "google_container_cluster" "new_cluster" {
    name                            = var.cluster_name
    location                        = var.region
    project                         = var.project_id
    min_master_version              = var.gke_version
    initial_node_count              = 1
    remove_default_node_pool        = true 
    node_locations = ["${var.region}-a"]

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
  
  ip_allocation_policy {
    cluster_ipv4_cidr_block = var.worker_ipv4_cidr_block
  }

  maintenance_policy {
    recurring_window {
      start_time = var.maintenance_start_time
      end_time   = var.maintenance_end_time
      recurrence = "FREQ=WEEKLY;BYDAY=WE,TH"
    }
  }

}
