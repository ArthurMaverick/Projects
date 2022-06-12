resource "helm_release" "argocd" {
  create_namespace = true
  chart            = var.argo_chart
  namespace        = var.argo_namespace
  repository       = var.argo_repository 
  name             = var.argo_helm_name
  version          = var.argo_chart_version
  values = [
    "${file("values.yaml")}"
  ]
}

