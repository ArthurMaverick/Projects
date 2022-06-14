variable "project_name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "secondary_ip_range_name" {
  type = string
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