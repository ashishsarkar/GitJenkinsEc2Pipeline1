#!/bin/bash

sudo yum install unzip -y
wget https://releases.hashicorp.com/terraform/0.12.17/terraform_0.12.17_linux_amd64.zip
unzip terraform_0.12.17_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
