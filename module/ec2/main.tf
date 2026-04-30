resource "aws_instance" "jenkins" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.pub_subnet_ids
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/userdata.sh", {
    repo_url = var.repo_url
  })

  tags = {
    Name = var.instance_name
  }
}

# Elastic IP
resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
  domain   = "vpc"

  tags = {
    Name = "${var.instance_name}-eip"
  }
}

# Extra EBS Volume (for Jenkins data)
resource "aws_ebs_volume" "jenkins" {
  availability_zone = var.az
  size              = 10

  tags = {
    Name = "${var.instance_name}-jenkins-volume"
  }
}

resource "aws_volume_attachment" "jenkins_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.jenkins.id
  instance_id = aws_instance.jenkins.id
}

# Snapshot policy using Data Lifecycle Manager
resource "aws_dlm_lifecycle_policy" "ebs_snapshots" {
  description        = "Daily EBS snapshot"
  execution_role_arn = var.dlm_role_arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    target_tags = {
      Name = "${var.instance_name}-jenkins-volume"
    }

    schedule {
      name = "daily-snapshot"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
      }

      retain_rule {
        count = 7
      }
    }
  }
}