data "aws_subnet_ids" "private_subnet" {
  for_each = var.private_subnet_config
  
    filter {
      name   = "tag:Name"
      values = ["${each.tag_name}"]
    }
  
}
data "aws_subnet_ids" "public_subnet" {
  for_each = var.public_subnet_config
    
    filter {
      name   = "tag:Name"
      values = ["${each.tag_name}"]
    }
}


resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_ip
  instance_tenancy = "default"

  tags   = {
    Name = "${var.vpc_name}-vpc"
  }
}


resource "aws_route_table" "private_route_table_config" {
  for_each =  var.private_route_table_config
  
  vpc_id   = aws_vpc.vpc.id
  route    = []

  tags     = {
    Name   = each.value["tag_name"]
  }
}

resource "aws_route_table" "public_route_table_config" {
  for_each =  var.public_route_table_config
  
  vpc_id   = aws_vpc.vpc.id
  
  tags     = {
    Name   = each.value["tag_name"]
  }

  route {
    cidr_block = each.value["cidr_block"]
    gateway_id = aws_internet_gateway.example.id # TODO
  }
}


resource "aws_route_table_association" "private_route_table_association_config" {
  for_each      = data.aws_subnet_ids.private_subnet.ids
  
  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table_config.id
}
resource "aws_route_table_association" "public_route_table_association_config" {
  for_each      = data.aws_subnet_ids.public_subnet.ids
  
  subnet_id      = each.value
  route_table_id = aws_route_table.public_route_table_config.id
}


resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnet_config

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr_ip"]
  availability_zone = each.value["az"]
  
  tags   = {
    Name = each.value["tag_name"]
  }
}

resource "aws_subnet" "public_subnet" {
  for_each          = var.public_subnet_config

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value["cidr_ip"]
  availability_zone = each.value["az"]
  
  tags   = {
    Name =  each.value["tag_name"]
  }
}


resource "aws_security_group" "private_security_group" {
  for_each    = var.private_security_group_config

  name        = var.private_security_group_name
  description = "Enables access to ${var.private_security_group_name}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = each.values["ingress_from_port"]
    to_port     = each.values["ingress_to_port"]
    protocol    = each.values["ingress_protocol"]
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = each.values["egress_from_port"]
    to_port     = each.values["egress_to_port"]
    protocol    = each.values["egress_protocol"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.values["tag_name"]
  }
}

resource "aws_security_group" "public_security_group" {
  for_each    = var.public_security_group_config

  name        = var.public_security_group_name
  description = "Enables access to ${var.private_security_group_name}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = each.values["ingress_from_port"]
    to_port     = each.values["ingress_to_port"]
    protocol    = each.values["ingress_protocol"]
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = each.values["egress_from_port"]
    to_port     = each.values["egress_to_port"]
    protocol    = each.values["egress_protocol"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = each.values["tag_name"]
  }
}