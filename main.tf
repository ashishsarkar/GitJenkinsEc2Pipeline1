resource "aws_cloudwatch_log_group" "cw_log_group" {
  name = "${var.cw_log_group_name}"
}


resource "aws_instance" "cw_agent_instance" {
	ami = "${var.ami_id_name}"
	instance_type = "${var.instance_type_name}"
	key_name = "${var.key_pair_name}"
	user_data = "${file("cw_agent_install.sh")}"
    iam_instance_profile = "${var.iam_instance_profile}"
	tags = {
    Name  = "${var.name_tag}"
    Email = "${var.owner_tag}"
    Owner = "${var.email_tag}"
  }
}


resource "aws_cloudwatch_log_stream" "cw_log_group_stream" {
  name           = "${aws_instance.cw_agent_instance.id}"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group.name}"
}
