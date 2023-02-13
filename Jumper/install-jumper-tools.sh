#!/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
sudo yum install -y wget vim unzip git terraform azure-cli maven
wget https://s3.eu-west-1.amazonaws.com/shmulik.kaufman/bbw/jdk-11.0.17_linux-x64_bin.rpm
sudo rpm -ivh jdk-11.0.17_linux-x64_bin.rpm
rm -rf ./get_helm.sh jdk-11.0.17_linux-x64_bin.rpm kubectl
cp ~/BBW-DIH-k8s/Jumper/.banner.txt /home/centos/
echo "clear" >> /home/centos/.bashrc 
echo "cat /home/centos/.banner.txt" >> /home/centos/.bashrc
