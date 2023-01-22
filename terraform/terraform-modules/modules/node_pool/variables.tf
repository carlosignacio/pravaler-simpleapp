variable "pool_name" {
    description = "Name of the node pool"
}

variable "cluster_name" {
    description = "Name of the cluster"
}

variable "region" {
    description = "Region of the cluster"
}

variable "project_id" {
    description = "Project ID of the cluster"
}

variable "gke_version" {
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

variable "machine_type" {
    description = "Machine type of the nodes"
}

variable "label_node" {
    type        = string
    description = "Label of the nodes"  
}

variable "label_name" {
    description = "Label of the nodes"  
}