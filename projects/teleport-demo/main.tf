module "project" {
  source = "../../modules/cloud/gcp/project"
  project_name = "demo"
  project_display_name = "lab"
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
  service_account_name  = module.service_account.name
  service_account_email = module.service_account.email

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

provider "kubernetes" {
  load_config_file = "false"

  host     = module.gke.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = module.gke.master_auth.0.client_certificate
  client_key             = module.gke.master_auth.0.client_key
  cluster_ca_certificate = module.gke.master_auth.0.cluster_ca_certificate
}

module "k8s_secrets" {
  source            = "../../modules/cloud/k8s/secrets"
  secret_name       = "teleport-gcp-credentials"
  secret_namespace  = "teleport"
  secret_key        = "teleport-gcp-credentials"
  secret_path       = "${file("${path.module}/vault-admin-credentials.json")}"
}



