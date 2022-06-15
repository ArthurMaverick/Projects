######################
##### PROJECTNAME #####
######################
variable "project_name" {
  type = string
}
variable "project_display_name" {
  type = string 
}
variable "project_id" {
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


######################
###  K8S SECRETS  ####
######################
variable "secret_name" {
  type = string
}
variable "secret_namespace" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "secret_path" {
  type = string
}