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
variable "role_id" {
  type = string
}
variable "role_name" {
  type = string
}
variable "role_title" {
  type = string
}
variable "role_description" {
  type = string
}
variable "role_permissions" {
  type = string
}

######################
###### TELEPORT ######
######################


######################
### SERVICECCOUNT ####
######################
variable "account_id" {
  type = string
}
variable "display_name" {
  type = string
}
variable "description" {
  type = string
}
variable "service_account_name" {
  type = string
}
variable "custom_role_bind" {
  type = string
}
variable "default_role_bind" {
  type = string
}
