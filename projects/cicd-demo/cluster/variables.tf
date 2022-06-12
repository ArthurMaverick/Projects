# KIND CLUSTER
variable "kind_cluster_name" {
  type        = string
  description = "The name of Cluster"
  default     = "local-cluster"
}
variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}

# ARGO CD
variable "argo_chart" {
    type        = string
    description = "argo chart"
}
variable "argo_namespace" {
    type        = string
    description = "argo namespace"
}
variable "argo_repository" {
    type        = string
    description = "argo repository"
}
variable "argo_helm_name" {
    type        = string
    description = "argo helm name"
}
variable "argo_chart_version" {
    type        = string
    description = "argo chart version"
}

# TEKTON CI
variable "tekton_chart_version" {
    type        = string
    description = "current tekton chart version"
}
variable "tekton_chart_path" {
    type        = string
    description = "current tekton chart path"
}
variable "tekton_chart_values_path" {
    type        = string
    description = "current tekton chart value path"
}

# TELEPORT
variable "teleport_chart_version" {
  type        = string
  description = "current teleport chart version"
}
variable "teleport_repository" {
  type        = string
  description = "current teleport chart path"
}
variable "teleport_chart_values_path" {
  type        = string
  description = "current teleport chart value path"
}