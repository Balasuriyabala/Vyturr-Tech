module "vpc" {
  source = "../../module/vpc"

  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "iam" {
  source    = "../../module/iam"
  role_name = "dlm-role-prod"
}

module "ec2" {
  source = "../../module/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  #subnet_id     = module.vpc.public_subnet_id
  pub_subnet_ids = module.vpc.public_subnet_id
  sg_id         = module.sg.sg_id
  key_name      = var.key_name
  instance_name = var.instance_name
  repo_url      = var.repo_url
  az            = var.az
  dlm_role_arn  = var.dlm_role_arn
  ebs_volume_size = var.ebs_volume_size
  ebs_volume_type = var.ebs_volume_type
}

module "sg" {
  source = "../../module/sg"

  sg_name = "jenkins-sg"
  vpc_id  = module.vpc.vpc_id

  ingress_rules = {
    ssh = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }

    jenkins = {
      from_port = 8080
      to_port   = 8080
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  }
}


module "dlm" {
  source          = "../../module/dlm"
  dlm_role_arn    = module.iam.dlm_role_arn
  retention_count = 7
}