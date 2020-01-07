resource "aws_cloudwatch_log_group" "cw_log_group" {
  name = "${var.cw_log_group_name}"
}


# resource "aws_instance" "cw_agent_instance" {
# 	ami = "${var.ami_id_name}"
# 	instance_type = "${var.instance_type_name}"
# 	key_name = "${var.key_pair_name}"
# 	user_data = "${file("cw_agent_install.sh")}"
#     iam_instance_profile = "${var.iam_instance_profile}"
# 	tags = {
#     Name  = "${var.name_tag}"
#     Email = "${var.owner_tag}"
#     Owner = "${var.email_tag}"
#   }
# }


resource "aws_cloudwatch_log_stream" "cw_log_group_stream" {
  name           = "${aws_instance.cw_agent_instance.id}"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group.name}"
}


data "aws_lambda_function" "logs_to_elasticsearch_logs" {
  function_name = "${var.aws_lambda_function_name}"
  qualifier = ""
}

resource "aws_lambda_permission" "logs_to_elasticsearch_logs" {
  action        = "${var.aws_lambda_permission_action_name}"
  function_name = "${data.aws_lambda_function.logs_to_elasticsearch_logs.function_name}"
  principal     = "${var.aws_lambda_permission_action_principal}"
  source_arn    = "${aws_cloudwatch_log_group.cw_log_group.arn}"
}


resource "aws_cloudwatch_log_subscription_filter" "logs_to_elasticsearch_logs" {
  name            = "ElasticsearchStream-logs"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group.name}"
  filter_pattern  = ""  
  destination_arn = "${data.aws_lambda_function.logs_to_elasticsearch_logs.arn}"
  depends_on      = ["aws_lambda_permission.logs_to_elasticsearch_logs"]
}
