variable "vpc_name" {
  description = "vpc"
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

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "repo_url" {
  type = string
}

variable "dlm_role_arn" {
  type = string
}