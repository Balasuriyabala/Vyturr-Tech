vpc_name            = "prod-vpc"
cidr_block          = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
az                  = "ap-south-1a"
aws_region          = "ap-south-1"

ami           = "ami-0e12ffc2dd465f6e4"
instance_type = "t2.micro"
key_name      = "your-keypair"
instance_name = "jenkins-server"

repo_url = "https://github.com/Balasuriyabala/docker-compose.git"

dlm_role_arn = "arn:aws:iam::381491890370:role/AWSDataLifecycleManagerDefaultRole"