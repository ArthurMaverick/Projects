######################
##### PROJECTNAME #####
######################
variable "project_name" {
  type = string
}
variable "project_display_name" {
  type = string 
}

######################
##### KUBERNETES #####
######################
variable "gke_username" {
  type = bool
  default = false
}
variable "gke_password" {
  type = bool
  default = false
}
variable "initial_node_count" {
  type = number
  default = 1
}
variable "cluster_autoscaling" {
  type = bool
  default = true
}
variable "min_nodes_limits" {
  type = number
  default = 1
}
variable "max_nodes_limits" {
  type = number
  default = 2
}

######################
######    AWS   ######
######################
variable "aws_region" {
  type = string
}

variable "gcp_region" {
  type = string
}
######################
###### TELEPORT ######
######################
