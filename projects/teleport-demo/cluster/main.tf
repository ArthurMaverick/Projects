module "project" {
  source = "../../modules/cloud/gcp/project"
  project_name = var.project_name
  project_display_name = var.project_display_name
}

module "network" {
  source       = "../../modules/cloud/gcp/network"
  project_name = module.project.name
}

module "subnet" {
  source       = "../../modules/cloud/gcp/subnet"
  network      = module.network.id
  project_name = module.project.name
}

module "gke" {
  source                  = "../../modules/cloud/gcp/gke"
  secondary_ip_range_name = module.network.id
  project_name            = module.project.name
  project_id              = module.project.id
  initial_node_count      = var.initial_node_count
  cluster_autoscaling     = var.cluster_autoscaling
  min_nodes_limits        = var.cluster_autoscaling ? var.min_nodes_limits : 1
  max_nodes_limits        = var.cluster_autoscaling ? var.max_nodes_limits : 2
}


## K8S PROVIDER
provider "kubernetes" {
  load_config_file = "false"

  host     = module.gke.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = module.gke.master_auth.0.client_certificate
  client_key             = module.gke.master_auth.0.client_key
  cluster_ca_certificate = module.gke.master_auth.0.cluster_ca_certificate
}
