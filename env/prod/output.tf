output "aws_eip_jenkins_public_ip" {
  value = module.ec2.aws_eip_jenkins_public_ip
}

output "jenkins_instance_id" {
  value = module.ec2.instance_id
}