# Local Cluster
kind_cluster_name         = "project"
kind_cluster_config_path  = "~/.kube/config"

# Argo CD
argo_chart         = "bitnami/argo-cd"
argo_namespace     = "argocd"
argo_repository    = "https://charts.bitnami.com/bitnami"
argo_helm_name     = "argocd-demo"
argo_chart_version = "0.0.1"

# Tekton CI
tekton_chart         = ""
tekton_namespace     = ""
tekton_repository    = "https://charts.bitnami.com/bitnami"
tekton_helm_name     = ""
tekton_chart_version = "0.0.1"

# Teleport
teleport_chart         = ""
teleport_namespace     = ""
teleport_repository    = "https://charts.bitnami.com/bitnami"
teleport_helm_name     = ""
teleport_chart_version = "0.0.1"