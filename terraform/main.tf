
# Network Configuration
#=============================================================================
module "network_config" {
  source = "terraform/terraform-modules/modules/network"
  
  project_id                  = var.project_id
  region                      = var.region
}


#=============================================================================#
# Cluster GKE Configuration
module "cluster_gke" {
  source                      = "terraform/terraform-modules/modules/cluster"

  cluster_name                = var.cluster_name
  region                      = var.region
  project_id                  = var.project_id
  gke_version                 = var.gke_version
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  worker_ipv4_cidr_block      = var.worker_ipv4_cidr_block

  depends_on                  = [module.network_config]
}

module "microservices_node_pool" {
  source                      = "terraform/terraform-modules/modules/node_pool"

  pool_name                   = "microservices"
  cluster_name                = var.cluster_name
  region                      = var.region
  project_id                  = var.project_id
  gke_version                 = var.gke_version
  max_nodes                   = var.max_nodes
  min_nodes                   = var.min_nodes
  machine_type                = "n2-standard-4"
  #machine_type                = "t2a-standard-1"
  label_name                  = "certi-microservices-np"
  label_node                  = "certi-microservices-np"

  depends_on                  = [module.cluster_gke]
}

module "satelite_node_pool" {
  source                      = "terraform/terraform-modules/modules/node_pool"

  pool_name                   = "satelite"
  cluster_name                = var.cluster_name
  region                      = var.region
  project_id                  = var.project_id
  gke_version                 = var.gke_version
  max_nodes                   = var.max_nodes
  min_nodes                   = var.min_nodes
  machine_type                = "n2-standard-4"
  #machine_type                = "t2a-standard-1"
  label_name                  = "pravaler-satelite-np"
  label_node                  = "pravaler-satelite-np"

  depends_on                  = [module.cluster_gke]
}