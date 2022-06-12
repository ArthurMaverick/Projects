resource "helm_release" "teleport" {
  create_namespace = true
  chart            = var.teleport_chart
  namespace        = var.teleport_namespace
  repository       = var.teleport_repository 
  name             = var.teleport_helm_name
  version          = var.teleport_chart_version
  values = [
    "${file("values.yaml")}"
  ]
}

