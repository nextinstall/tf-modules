# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP RULES THAT CONTROL WHAT CLIENT TRAFFIC CAN GO IN AND OUT OF A DOMAIN CONTROLLER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group_rule" "allow_client_ICMP_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = 8
  to_port     = 0
  protocol    = "icmp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_http_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_http_port}"
  to_port     = "${var.server_http_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

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

