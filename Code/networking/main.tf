provider "aws" {
  region = "us-east-1"
}

# VPC Creation

resource "aws_vpc" "aws_vpc_definition" {
  cidr_block = var.aws_vpc_cidr_block
  tags = {
    Name = var.aws_vpc_name
  }
}

resource "aws_subnet" "aws_subnet_definition-az1" {
  vpc_id     = aws_vpc.aws_vpc_definition.id
  cidr_block = var.aws_subnet_cidr_block

  tags = {
    Name = "${var.aws_vpc_name}-${var.aws_subnet_name}"
  }
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = var.aws_domain_name_servers
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.aws_vpc_definition.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

resource "aws_security_group" "allow_remote" {
  name        = "allow_remote"
  description = "Allow remote inbound traffic"
  vpc_id      = aws_vpc.aws_vpc_definition.id

  ingress {
    description = "SSH"
    from_port   = var.aws_from_port_ingress
    to_port     = var.aws_to_port_ingress
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.aws_vpc_definition.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_remote"
  }
}