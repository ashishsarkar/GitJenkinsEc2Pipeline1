# Updating region
region = "us-east-1"



# CloudWatch Log Group and Stream Details
cw_log_group_name = "Nginx-Error"

# tags
name_tag = "Jenkins-Minesh-Demo-Machine"
owner_tag = "Ashish Sarkar"
email_tag = "ashish.sarkar@gmail.com"

# EC2 Details
ami_id_name = "ami-00068cd7555f543d5"
instance_type_name = "t3.micro"
key_pair_name = "kumail_kpr"
iam_instance_profile = "aws-elasticbeanstalk-ec2-role"


# AWS cloudwatch Subscription filter
#lambda_function_streams_name = 
#lambda_function_streams_arn = "arn:aws:lambda:us-east-1:875012586337:function:LogsToElasticsearch_test-domain"


# Log subscription filter name
#subscription_filter_name = "LogsToElasticsearch_test-domain"
#role_arn = "lambda_elasticsearch_execution role"
