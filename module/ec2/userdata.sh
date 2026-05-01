#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x
set -e

yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

# Install Git
yum install git -y

# Install Docker Compose plugin (modern)
yum install docker-compose-plugin -y

# EBS mount (persistent storage)
if ! blkid /dev/xvdf; then
  mkfs -t ext4 /dev/xvdf
fi

mkdir -p /jenkins
mount /dev/xvdf /jenkins
echo "/dev/xvdf /jenkins ext4 defaults,nofail 0 2" >> /etc/fstab

# Clone GitHub repo
cd /home/ec2-user
git clone ${repo_url}
#git clone https://github.com/Balasuriyabala/docker-compose.git jenkins

cd jenkins

# Start Jenkins
docker compose up -d