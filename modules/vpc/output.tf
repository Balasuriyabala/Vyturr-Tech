output "vpc_id" {
  value       = aws_vpc.k8vpc.id
  description = "VPC ID where EKS cluster is deployed"
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  description = "Public subnet IDs for EKS load balancers"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  description = "Private subnet IDs for EKS nodes"
}

output "nat_gateway_public_ip" {
  value       = aws_eip.nat.public_ip
  description = "All outbound traffic from EKS nodes comes from this IP"
}