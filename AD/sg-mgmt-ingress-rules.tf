# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP RULES THAT CONTROL WHAT MGMT TRAFFIC CAN GO IN AND OUT OF A DOMAIN CONTROLLER
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_security_group_rule" "allow_rdp_inbound" {
#   count       = "${length(var.allowed_mgmt_cidr_blocks) >= 1 ? 1 : 0}"
#   type        = "ingress"
#   from_port   = "3389"
#   to_port     = "3389"
#   protocol    = "tcp"
#   cidr_blocks = ["${var.allowed_mgmt_cidr_blocks}"]

#   security_group_id = "${aws_security_group.mgmt_security_group.id}"
# }

# resource "aws_security_group_rule" "allow_winrm_inbound" {
#   count       = "${length(var.allowed_mgmt_cidr_blocks) >= 1 ? 1 : 0}"
#   type        = "ingress"
#   from_port   = "5985"
#   to_port     = "5986"
#   protocol    = "tcp"
#   cidr_blocks = ["${var.allowed_mgmt_cidr_blocks}"]

#   security_group_id = "${aws_security_group.mgmt_security_group.id}"
# }

resource "aws_security_group_rule" "allow_all_tcp" {
  count             = "${length(var.allowed_mgmt_cidr_blocks) >= 1 ? 1 : 0}"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${var.allowed_mgmt_cidr_blocks}"]
  security_group_id = "${aws_security_group.mgmt_security_group.id}"
}

resource "aws_security_group_rule" "allow_all_udp" {
  count             = "${length(var.allowed_mgmt_cidr_blocks) >= 1 ? 1 : 0}"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  cidr_blocks       = ["${var.allowed_mgmt_cidr_blocks}"]
  security_group_id = "${aws_security_group.mgmt_security_group.id}"
}
