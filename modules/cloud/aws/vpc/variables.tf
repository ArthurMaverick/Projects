########################## VPC ########################################
variable "vpc_cidr_ip" {
  description = "vpc cidr"
  default     = "10.0.0.0/16"
}
variable "vpc_name" {
  description = "vpc's name"
  default     =  "demo"
}

########################## ROUTES TABLE ###############################
########### PRIVATE RT
variable "private_route_table_config" {
  type = map
  default = {
    private_rt_1 = {
      tag_name    = "private-route-table-1"
    }
  }
}
########### PUBLIC RT
variable "public_route_table_config" {
  type = map
  default = {
    pubic_rt_1 = {
      cidr_block  = "0.0.0.0/0"
      tag_name    = "public-route-table-1"
    }
  }
}


########################## SUBNETS ####################################
########### PRIVATE SN
variable "private_subnet_config" {
  type = map
  default = {
    private_sn_1 = {
      az       = "us-east-1a"
      cidr_ip  = "10.10.10.10/24"
      tag_name = "private-subnet-1"
    }
  }
}
########### PUBLIC SN
variable "puplic_subnet_config" {
  type = map
  default = {
    public_sn_1 = {
      az       = "us-east-1b"
      cidr_ip  = "10.20.20.20/24"
      tag_name = "public-subnet-1"
    }
  }
}

########################## SECURITY GROUPS ############################
########### PRIVATE SG
variable "private_security_group_name" {
  description = "security group name"
  default     = "private_security_groups"
} 
variable "private_security_group_config" {
  type = map
  default       = {
    private_sg_1 = {
      name              = "private-sg-2"
      tag_name          = "private-sg-2"
      ingress_from_port = "0"
      ingress_to_port   = "65535"
      ingress_protocol  = "tcp"
      egress_from_port  = "0"
      egress_to_port    = "65535"
      egress_protocol   = "-1"
    }
  }
}
########### PUBLIC SG
variable "public_security_group_name" {
  description = "security group name"
  default     = "public_security_groups"
} 
variable "public_security_group_config" {
  type = map
  default      = {
    public_sg_1 = {
      name              = "public-sg-1"
      tag_name          = "public-sg-1"
      ingress_from_port = "0"
      ingress_to_port   = "65535"
      ingress_protocol  = "tcp"
      egress_from_port  = "0"
      egress_to_port    = "65535"
      egress_protocol   = "-1"
    }
  }
}


