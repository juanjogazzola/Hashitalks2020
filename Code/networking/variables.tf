variable "aws_vpc_name" {
  type  = string
  description = "This is the name of the vpc"
  default = null
}

variable "aws_subnet_name" {
  type = string
}

variable "aws_vpc_cidr_block" {
  type = string
}

variable "aws_subnet_cidr_block" {
  type = string
}

variable "aws_domain_name_servers" {
  type = list
}

variable "aws_from_port_ingress" {
  type = number
}

variable "aws_to_port_ingress" {
  type = number
}
