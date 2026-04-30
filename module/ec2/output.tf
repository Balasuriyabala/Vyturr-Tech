output "instance_id" {
  value = aws_instance.jenkins.id
}

output "aws_eip_jenkins_public_ip" {
  value = aws_eip.jenkins_eip.public_ip
}

output "ebs_volume_id" {
  value = aws_ebs_volume.jenkins.id
}

