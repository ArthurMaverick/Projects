module "network" {
  source       = "../../modules/cloud/gcp/network"
  type_project = var.type_project
}

module "subnet" {
  source       = "../../modules/cloud/gcp/subnet"
  network      = module.network.id
  type_project = var.type_project
}

module "gke" {
  source                  = "../../modules/cloud/gcp/gke"
  secondary_ip_range_name = module.network.id
  type_project            = var.type_project
  initial_node_count      = var.initial_node_count 
  cluster_autoscaling     = var.cluster_autoscaling
  min_nodes_limits        = var.cluster_autoscaling ? var.min_nodes_limits : 1
  max_nodes_limits        = var.cluster_autoscaling ? var.max_nodes_limits : 2
}

module "roles" {
  source        = "../../modules/cloud/gcp/role"
  for_each      = var.role_config
  role_id       = each.value["role_id"]
  title         = each.value["title"] 
  description   = each.value["description"]
  permissions   = each.value["permissions"]
}

