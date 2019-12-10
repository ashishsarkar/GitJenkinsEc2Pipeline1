#!/bin/bash

sudo wget https://s3.eu-central-1.amazonaws.com/amazoncloudwatch-agent-eu-central-1/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
sudo chmod 777 /opt/aws/amazon-cloudwatch-agent/bin/
sudo touch /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo chmod 777 /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo echo "
{
        "agent": {
                "run_as_user": "root"
        },
        "logs": {
                "logs_collected": {
                        "files": {
                                "collect_list": [
                                        {
                                                "file_path": "/etc/nginx/nginx.conf",
                                                "log_group_name": "Nginx-Error",
                                                "log_stream_name": "{instance_id}"
                                        }
                                ]
                        }
                }
        }
}" >> /opt/aws/amazon-cloudwatch-agent/bin/config.json

sudo chmod 444 /opt/aws/amazon-cloudwatch-agent/bin/config.json 
systemctl enable amazon-cloudwatch-agent
