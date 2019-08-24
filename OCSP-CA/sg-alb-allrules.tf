# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT CONTROL WHAT CLIENT TRAFFIC CAN Go TO THE LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "lb" {
  description = "${var.env_level} ${var.product} OCSP Load Balancer Security Group"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags {
    Name        = "${var.env_level}-${var.product}-OCSP-ALB-sg"
    Environment = "${var.Environment}"
    env_level   = "${var.env_level}"
    product     = "${var.product}"
    role        = "Security Group"
    platform    = "${var.platform}"

    #huit_assetid = "${var.huit_assetid}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP RULES THAT CONTROL WHAT CLIENT TRAFFIC CAN GO IN AND OUT OF A DOMAIN CONTROLLER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group_rule" "allow_client_http_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_http_port}"
  to_port     = "${var.server_http_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.lb.id}"
}

resource "aws_security_group_rule" "allow_client_https_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_https_port}"
  to_port     = "${var.server_https_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.lb.id}"
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lb.id}"
}

resource "aws_security_group_rule" "allow_lb_sg_to_instance_http" {
 type                     = "ingress"
 from_port                = "${var.server_http_port}"
 to_port                  = "${var.server_http_port}"
 protocol                 = "tcp"
 source_security_group_id = "${aws_security_group.lb.id}"
 security_group_id = "${aws_security_group.clients_security_group.id}"
}
resource "aws_security_group_rule" "allow_lb_sg_to_instance_https" {
 type                     = "ingress"
 from_port                = "${var.server_https_port}"
 to_port                  = "${var.server_https_port}"
 protocol                 = "tcp"
 source_security_group_id = "${aws_security_group.lb.id}"
 security_group_id = "${aws_security_group.clients_security_group.id}"
}


/*
POTENTIALLY USED FOR SG based rule grouping (T0/T0 on SG boundaries)
*/


/*
POTENTIALLY USED FOR SG based rule grouping (T0/T0 on SG boundaries)
*/
#resource "aws_security_group_rule" #"allow_server_rpc_inbound_from_security_group_ids" {
#  count                    = "${length(var.allowed_inbound_security_group_ids)}"
#  type                     = "ingress"
#  from_port                = "${var.server_rpc_port}"
#  to_port                  = "${var.server_rpc_port}"
#  protocol                 = "tcp"
#  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"
#
#  security_group_id = "${aws_security_group.clients_security_group.id}"
#}

