terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"
    }
     helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Get EKS cluster details
//data "aws_eks_cluster" "eks" {
//  name = module.eks.cluster_name
//}

//data "aws_eks_cluster_auth" "eks" {
//  name = module.eks.cluster_name
//}

# Kubernetes provider
//provider "kubernetes" {
//  host                   = data.aws_eks_cluster.eks.endpoint
//  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
//  token                  = data.aws_eks_cluster_auth.eks.token
//}

# Helm provider
//provider "helm" {
//  kubernetes {
//    host                   = data.aws_eks_cluster.eks.endpoint
//    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
//    token                  = data.aws_eks_cluster_auth.eks.token
//  }
//}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
