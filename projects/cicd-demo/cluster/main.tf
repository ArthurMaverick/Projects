// INSTALL LOCAL KIND CLUSTER
module "kind_cluster" {
  source                   = "..modules/clusters/local/kind" # TODO refactor path 
  kind_cluster_name        = var.kind_cluster_name
  kind_cluster_config_path = var.kind_cluster_config_path
}


//PARALLEL HELM INSTALL ON KIND CLUSTER
# TODO CHANGE TO ARGO WORKFLOW
module "tekton" {    
  source               = "../../../../modules/cicd/argo-workflows"
  tekton_chart         = var.tekton_chart
  tekton_namespace     = var.tekton_namespace
  tekton_repository    = var.tekton_chart_values_path
  tekton_helm_name     = var.tekton_chart_version
  tekton_chart_version = var.tekton_helm_name

  depends_on           = [module.kind_cluster]
}

module "argocd" {
  source             = "../../../../modules/services/cicd/argo-cd"
  argo_chart         = var.argo_chart
  argo_namespace     = var.argo_namespace
  argo_repository    = var.argo_chart_values_path
  argo_helm_name     = var.argo_chart_version
  argo_chart_version = var.argo_helm_name

  depends_on         = [module.kind_cluster]
}

module "teleport" {
  source                 = "../../../../modules/services/security/teleport"
  teleport_chart         = var.teleport_chart
  teleport_namespace     = var.teleport_namespace
  teleport_repository    = var.teleport_chart_values_path
  teleport_helm_name     = var.teleport_chart_version
  teleport_chart_version = var.teleport_helm_name

  depends_on             = [module.kind_cluster]
}