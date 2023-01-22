provider "google" {
  credentials = file("terraform-sa.json")
  project = var.project_id
  region  = var.region
}

terraform {

  backend "gcs" {
    credentials = "terraform-sa.json"
    bucket  = "pravaler-states"
    prefix  = "cme-lab"
  }
  
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.30.0"
    }
  } 
}
