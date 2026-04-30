variable "vpc_name" {
  description = "Name for the VPC"
  type = string
}
variable "cidr_block" {
  type = string
}
variable "public_subnet_cidr" {
  type = string
}
variable "private_subnet_cidr" {
  type = string
}
variable "az" {
  type = string
}

variable "aws_region" {
  type = string
}

## EKS Variables
variable "cluster_name" {
  type = string
}

variable "env" {
  type = string
}