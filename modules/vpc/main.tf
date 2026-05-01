resource "aws_vpc" "k8vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true   # needed for EKS to work correctly

  tags = { Name = "authentik-vpc" }
}

resource "aws_internet_gateway" "k8igw" {
  vpc_id = aws_vpc.k8vpc.id
  tags   = { Name = "authentik-igw" }
}

# Public Subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.k8vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public-subnet-1"
    "kubernetes.io/role/elb" = "1"   # allows AWS Load Balancer to use this subnet
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.k8vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public-subnet-2"
    "kubernetes.io/role/elb" = "1"
  }
}

#Private Subnets
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.k8vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Name                              = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.k8vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2
  tags = {
    Name                              = "private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.k8igw]
  tags={ 
    Name = "nat-eip"
    }
}

resource "aws_nat_gateway" "k8nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id   # NAT lives in PUBLIC subnet
  depends_on    = [aws_internet_gateway.k8igw]
  tags          = { Name = "authentik-nat" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8igw.id
  }
  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.k8vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.k8nat.id
  }
  tags = { Name = "private-rt" }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}
