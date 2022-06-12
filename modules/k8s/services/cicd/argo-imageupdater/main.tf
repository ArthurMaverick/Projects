resource "helm_release" "tekton" {
  create_namespace = true
  chart            = var.tekton_chart
  namespace        = var.tekton_namespace
  repository       = var.tekton_repository 
  name             = var.tekton_helm_name
  version          = var.tekton_chart_version
  values = [
    "${file("values.yaml")}"
  ]
}

