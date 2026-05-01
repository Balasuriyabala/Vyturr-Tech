module "vpc" {
  source = "./modules/vpc"

  cidr_block            = var.cidr_block
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source = "./modules/eks"

  eks_cluster_name = var.eks_cluster_name
  cluster_version  = var.cluster_version

  subnet_ids = module.vpc.private_subnet_ids

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  node_groups = var.node_groups
}