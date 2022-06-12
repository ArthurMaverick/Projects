variable "type_project" {
  type = string
}
######################
##### KUBERNETES #####
######################
variable "initial_node_count" {
  type = number
  default = 1
}
variable "cluster_autoscaling" {
  type = bool
  default = false
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
####### ROLES ########
######################
variable "role_config" {
  type = map
}

######################
###### TELEPORT ######
######################

