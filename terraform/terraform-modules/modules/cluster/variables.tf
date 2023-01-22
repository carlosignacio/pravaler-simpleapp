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

variable "master_ipv4_cidr_block" {
  description = "IPv4 CIDR block of the master nodes"
}

variable "worker_ipv4_cidr_block" {
  description = "IPv4 CIDR block of the worker nodes"
}

variable "maintenance_start_time" {
  default = "2021-06-10T12:00:00Z"
  description = "Start time of the maintenance window"
}

variable "maintenance_end_time" {
  default = "2021-06-10T21:00:00Z"
  description = "End time of the maintenance window"
}