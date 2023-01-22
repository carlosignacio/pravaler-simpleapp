variable "cluster_name" {
    default = "pravaler-lab"
    description = "Name of the cluster"
}

variable "region" {
    default = "us-central1"
    description = "Region of the cluster"
}

variable "project_id" {
    default = "prime-radio-375011"
    description = "Project ID of the cluster"
}

variable "gke_version" {
    default = "1.24.8-gke.2000"
    description = "GKE version of the cluster"
}

variable "max_nodes" {
    default = "2"
    description = "Maximum number of nodes in the cluster"
}
  
variable "min_nodes" {
    default = "1"
    description = "Minimum number of nodes in the cluster"
}

variable "master_ipv4_cidr_block" {
    default = "172.16.1.0/28"
    description = "IPv4 CIDR block of the master nodes"
}

variable "worker_ipv4_cidr_block" {
    default = "10.92.0.0/14"
    description = "IPv4 CIDR block of the worker nodes Ex: 10.44.0.0/14 for southamerica or 10.92.0.0/14 for us-central1"
}

# variable "root_password" {
#     description = "Root password microservice sql instance"
# }

# variable "root_password_sql_user" {
#     description = "Root password user database sql instance"
# }

# variable "sql_kong" {
#     default = "kong"
#     description = "Root password database sql kong"
# }

# variable "user_password_kong" {
#     default = "Q4P0x75WKh"
#     description = "User password databese kong"
# }

