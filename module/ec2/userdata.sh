#!/bin/bash
yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user

# Install Git
yum install git -y

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Mount EBS volume
mkfs -t ext4 /dev/xvdf
mkdir -p /jenkins
mount /dev/xvdf /jenkins
echo "/dev/xvdf /jenkins ext4 defaults,nofail 0 2" >> /etc/fstab

# Clone repo
cd /home/ec2-user
git clone ${repo_url} jenkins

cd jenkins

# Run Jenkins
/usr/local/bin/docker-compose up -d