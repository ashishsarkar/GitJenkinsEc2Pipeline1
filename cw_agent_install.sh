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
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start



# Create directories
mkdir /home/ec2-user/MCOPD_866_sprint
cd /home/ec2-user/MCOPD_866_sprint && mkdir bash_script_error_tail error_log_dir new_log_file_dir python_script


# create bash_script_error_tail and input file to it
sudo echo "
tail -1 /home/ec2-user/MCOPD_866_sprint/error_log_dir/error.log > /home/ec2-user/MCOPD_866_sprint/new_log_file_dir/new_log_file.log
python cw_scripts.py
" >> /home/ec2-user/MCOPD_866_sprint/bash_script_error_tail/error_tail.sh
chmod 777 /home/ec2-user/MCOPD_866_sprint/bash_script_error_tail/error_tail.sh


# create error_log_dir and input file to it
sudo echo "
1.1.4.184 - - [10/Nov/2019:10:22:06 +0000] "GET / HTTP/1.1" 200 3700 "-" "ELB-HealthChecker/2.0" "-"
" >> /home/ec2-user/MCOPD_866_sprint/error_log_dir/error.log


# create new_log_file_dir and input file to it
sudo echo "
1.1.4.184 - - [10/Nov/2019:10:22:06 +0000] "GET / HTTP/1.1" 200 3700 "-" "ELB-HealthChecker/2.0" "-"
" >> /home/ec2-user/MCOPD_866_sprint/new_log_file_dir/new_log_file.log


# create error_log_dir and input file to it
sudo echo "
1.1.4.184 - - [10/Nov/2019:10:22:06 +0000] "GET / HTTP/1.1" 200 3700 "-" "ELB-HealthChecker/2.0" "-"
" >> /home/ec2-user/MCOPD_866_sprint/python_script/cw_scripts.py
chmod 777 /home/ec2-user/MCOPD_866_sprint/python_script/cw_scripts.py

sudo echo "
* * * * * /home/ec2-user/MCOPD_866_sprint/bash_script_error_tail/error_tail.sh
" >> crontab
