
# Network Configuration
#=============================================================================
module "network_config" {
  source = "/home/cme/certi/terraform-modules/modules/network"
  
  project_id                  = var.project_id
  region                      = var.region
}


#=============================================================================#
# Cluster GKE Configuration
module "cluster_gke" {
  source                      = "/home/cme/certi/terraform-modules/modules/cluster"

  cluster_name                = var.cluster_name
  region                      = var.region
  project_id                  = var.project_id
  gke_version                 = var.gke_version
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  worker_ipv4_cidr_block      = var.worker_ipv4_cidr_block

  depends_on                  = [module.network_config]
}

module "microservices_node_pool" {
  source                      = "/home/cme/certi/terraform-modules/modules/node_pool"

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
  source                      = "/home/cme/certi/terraform-modules/modules/node_pool"

  pool_name                   = "satelite"
  cluster_name                = var.cluster_name
  region                      = var.region
  project_id                  = var.project_id
  gke_version                 = var.gke_version
  max_nodes                   = var.max_nodes
  min_nodes                   = var.min_nodes
  machine_type                = "n2-standard-4"
  #machine_type                = "t2a-standard-1"
  label_name                  = "certi-satelite-np"
  label_node                  = "certi-satelite-np"

  depends_on                  = [module.cluster_gke]
}

# #=============================================================================#
# # Kong API-Gateway Configuration
# module "kong_sql_instance" {
#   source                      = "/home/cme/certi/terraform-modules/modules/cloud_sql/instance"

#   project_id                  = var.project_id
#   region                      = var.region
#   instance_name               = "api-gw-database"

#   database_version            = "POSTGRES_9_6"
#   root_password               = var.sql_kong
#   database_tier               = "db-f1-micro"
#   database_disk_type          = "PD_HDD"

#   depends_on                  = [module.network_config]
# }

# module "kong_sql_database" {
#   source                      = "/home/cme/certi/terraform-modules/modules/cloud_sql/database"

#   project_id                  = var.project_id
#   database_instance           = module.kong_sql_instance.instance_name
#   database_name               = "kong"

#   depends_on                  = [module.kong_sql_instance]
# }

# module "konga_sql_database" {
#   source                      = "/home/cme/certi/terraform-modules/modules/cloud_sql/database"

#   project_id                  = var.project_id
#   database_instance           = module.kong_sql_instance.instance_name
#   database_name               = "konga"

#   depends_on                  = [module.kong_sql_instance]
# }

# module "kong_sql_user" {
#   source                      = "/home/cme/certi/terraform-modules/modules/cloud_sql/user"

#   project_id                  = var.project_id
#   database_instance           = module.kong_sql_instance.instance_name
#   database_user               = "kong"
#   user_password               = var.user_password_kong

#   depends_on                  = [module.kong_sql_instance]
# }

# module "kong_compute_instance" {
#   source                      = "/home/cme/certi/terraform-modules/modules/kong/"

#   project_id                  = var.project_id
#   region                      = var.region
#   worker_ipv4_cidr_block      = var.worker_ipv4_cidr_block

#   depends_on                  = [module.kong_sql_instance, module.kong_sql_user]
# }

# module "firewall_rules" {
#   source                    = "/home/cme/certi/terraform-modules/modules/firewall"

#   region                    = var.region
#   project_id                = var.project_id
#   source_ranges             = var.master_ipv4_cidr_block
#   target_tags_name          = "certi-cluster"
#   fw_rules_name             = "certi-istio"
#   fw_allow_ports            = ["8080","10250","443","15017","9443"]
# }
