aws_region            = "ap-south-1"

cidr_block            = "10.10.0.0/16"
availability_zones    = ["ap-south-1a", "ap-south-1b"]

public_subnet_1_cidr  = "10.10.1.0/24"
public_subnet_2_cidr  = "10.10.2.0/24"

private_subnet_1_cidr = "10.10.5.0/24"
private_subnet_2_cidr = "10.10.6.0/24"

eks_cluster_name      = "vyturr-eks-cluster"
cluster_version       = "1.27"

node_groups = {
  default = {
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"

    scaling_config = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
    }
  }
}