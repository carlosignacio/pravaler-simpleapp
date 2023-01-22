resource "google_container_node_pool" "new_node_pool" {
    name                    = var.pool_name
    location                = var.region
    project                 = var.project_id
    cluster                 = var.cluster_name
    version                 = var.gke_version
    node_count              = "1"
    max_pods_per_node       = "110"
    node_locations          = ["${var.region}-a"]
    
    autoscaling {
        min_node_count      = var.min_nodes
        max_node_count      = var.max_nodes
    }
    
    node_config {
        machine_type        = var.machine_type
        oauth_scopes        = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/devstorage.read_only",
        ]
        labels = {
                (var.label_name)  = var.label_node
        }
          tags                = ["pravaler-fw-target"]
    }

    management {
        auto_upgrade        = false
        auto_repair         = true
    }
}