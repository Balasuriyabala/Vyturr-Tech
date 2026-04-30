resource "aws_security_group" "jenkins-sg" {
  name        = var.sg_name
  description = "Security group for EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

# Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each = var.ingress_rules

  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
}

# Egress Rule (Allow all)
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}