data "template_file" "win_bootstrap" {
  count    = "${var.instance_count}"
  template = "${file("${path.module}/user_data.tpl")}"

  vars {
    system_name = "${var.env_level}-${var.product}-${format("OCSP%1d", (count.index))}"
  }
}

resource "aws_instance" "instance" {
  count         = "${var.instance_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  #iam_instance_profile     = "${var.iam_instance_profile}"
  user_data              = "${element(data.template_file.win_bootstrap.*.rendered, count.index)}"
  subnet_id              = "${element(data.aws_subnet_ids.nets.ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.clients_security_group.id}", "${aws_security_group.mgmt_security_group.id}", "${aws_security_group.all_outbound_security_group.id}"]

  volume_tags {
    Name         = "${var.env_level}-${var.product}-${format("OCSP%1d", count.index)}-EBS-primary"
    Environment  = "${var.Environment}"
    env_level    = "${var.env_level}"
    platform     = "${var.platform}"
    product      = "${var.product}"
    role         = "Elastic Block Storage Volume"
    huit_assetid = "${var.huit_assetid}"
  }

  tags {
    Name         = "${var.env_level}-${var.product}-${format("OCSP%1d", count.index)}"
    Environment  = "${var.Environment}"
    env_level    = "${var.env_level}"
    platform     = "${var.platform}"
    product      = "${var.product}"
    role         = "EC2 Instance"
    huit_assetid = "${var.huit_assetid}"
  }

  lifecycle {
    ignore_changes = ["volume_tags"]
  }
}

resource "aws_ebs_volume" "instance" {
  count             = "${var.instance_count}"
  availability_zone = "${aws_instance.instance.*.availability_zone[count.index]}"
  size              = "50"

  tags {
    Name         = "${var.env_level}-${var.product}-${format("OCSP%1d", count.index)}-EBS-secondary"
    Environment  = "${var.Environment}"
    env_level    = "${var.env_level}"
    platform     = "${var.platform}"
    product      = "${var.product}"
    role         = "Elastic Block Storage Volume"
    huit_assetid = "${var.huit_assetid}"
  }

  lifecycle {
    ignore_changes = ["Name"]
  }
}

resource "aws_volume_attachment" "instance" {
  count       = "${var.instance_count}"
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.instance.*.id[count.index]}"
  instance_id = "${aws_instance.instance.*.id[count.index]}"
}

resource "aws_cloudwatch_metric_alarm" "auto_recovery_alarm" {
count = "${var.instance_count}"
alarm_name = "EC2AutoRecover-${element(aws_instance.instance.*.id, count.index)}"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "5"
metric_name = "StatusCheckFailed_System"
namespace = "AWS/EC2"
period = "60"
statistic = "Minimum"

dimensions = {
  InstanceId = "${element(aws_instance.instance.*.id, count.index)}"
}

alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]

threshold = "1"
alarm_description = "Auto recover the EC2 instance if Status Check fails."
}