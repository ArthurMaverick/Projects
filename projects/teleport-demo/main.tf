module "network" {
  source       = "../../modules/cloud/gcp/network"
  project_name = var.project_name
}

module "subnet" {
  source       = "../../modules/cloud/gcp/subnet"
  network      = module.network.id
  project_name = var.project_name
}

module "gke" {
  source                  = "../../modules/cloud/gcp/gke"
  secondary_ip_range_name = module.network.id
  project_name            = var.project_name
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

module "service_account" {
  source = "../../modules/cloud/gcp/service-account"
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
}

module "custom_role_bind" {
  source = "../../modules/cloud/gcp/service-account/custom-role-binding"
  for_each              = module.roles.name
  custom_role_bind      = each.value
  service_account_name  =  module.service_account.name
  service_account_email =  module.service_account.email

  depends_on = [
    module.service_account,
    module.roles
  ]
}

module "default_role_bind" {
  source = "../../modules/cloud/gcp/service-account/default-role-binding"
  for_each              = var.default_role_bind
  default_role_bind     = each.value["role_bind"]
  service_account_name  = module.service_account.name
  service_account_email = module.service_account.email
  
  depends_on = [
    module.service_account
  ]
}