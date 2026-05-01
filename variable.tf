variable "availability_zones" {
  type = list(string)
}

variable "aws_region" {
  type = string
}
variable "cidr_block" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_groups" {
  type = any
}