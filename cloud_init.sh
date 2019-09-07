#!/bin/bash

#ssh pubkey
mkdir -p /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYiGNCEq4+gMpKaRXR5K/mSGeGO5Z4QPh852agg2U2tvYFX4MgDvuS6yXueIslzbsOJWluCi9rZkR0ZzCdD1DqbKQXyB7sbXW29FJj/5BMnxQaLW04T5hhLw97GxY+Kf5NG72ixLa7uNpZpBy06NA0nNAS8u+E2qYegSp2F5xcahUo1kRgqiYfrWe6g9JDnujk7SbtOMPQSnhUJpnacykrgckvlRuo+XjqQdYgn9q+MZPSVfmOZHCdr8BDuST2JhRGHqU5STcj/XpV8ADvkzirfIAXmRbFjC/U+KdxfCu8a/Rym+hTAv4hL3eix8CNBmd9fEUEicSLmQR5JMpfLFCd horni@feddy" >> /root/.ssh/authorized_keys

#hostname awx
hostnamectl set-hostname awx
#sed -i s/without-password/yes/ /etc/ssh/sshd_config

#node.js
curl -sL https://rpm.nodesource.com/setup_12.x | bash -

#yum packages: git docker ansible nodejs python-pip
yum -y install epel-release
yum -y install git docker ansible nodejs python-pip

#pip packages
pip install docker
pip install docker-compose

#selinux
setenforce permissive

#start docker unit
systemctl enable docker
systemctl start docker

#docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#awx repo
cd /root
git clone https://github.com/ansible/awx.git
cd awx/installer
ansible-playbook -i inventory install.yml


