variable "region" {
  default = "us-east-1"
}

variable "cw_log_group_name" {}

variable "name_tag" {}

variable "owner_tag" {}

variable "email_tag" {}

variable "ami_id_name" {}

variable "instance_type_name" {}

variable "key_pair_name" {}

variable "iam_instance_profile" {}

variable "aws_lambda_function_name" {}


variable "aws_lambda_permission_action_name" {}


variable "aws_lambda_permission_action_principal" {}


variable "lambda_function_streams_arn" {}


variable "subscription_filter_name" {}

variable "role_arn" {}
