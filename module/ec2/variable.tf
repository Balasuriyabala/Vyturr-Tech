variable "ami" {
    description = "amazonlinux"
    type = string
}
variable "instance_type" {
    type = string
}
variable "pub_subnet_ids" {
    type = string
}
variable "sg_id" {
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
variable "az" {
    type = string
}
variable "dlm_role_arn" {
    type = string
}