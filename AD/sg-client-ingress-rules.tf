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

resource "aws_security_group_rule" "allow_client_dns_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_dns_port}"
  to_port     = "${var.server_dns_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_dns_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_dns_port}"
  to_port     = "${var.server_dns_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_krb_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_krb_port}"
  to_port     = "${var.server_krb_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_krb_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_krb_port}"
  to_port     = "${var.server_krb_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_ntp_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_ntp_port}"
  to_port     = "${var.server_ntp_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_epmap_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_epmap_port}"
  to_port     = "${var.server_epmap_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_netbios_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_netbios_port}"
  to_port     = "${var.server_netbios_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_netbiosdg_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_netbiosdg_port}"
  to_port     = "${var.server_netbiosdg_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_netbiosss_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_netbiosss_port}"
  to_port     = "${var.server_netbiosss_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_krbpw_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_krbpw_port}"
  to_port     = "${var.server_krbpw_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_krbpw_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_krbpw_port}"
  to_port     = "${var.server_krbpw_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_ldap_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_ldap_port}"
  to_port     = "${var.server_ldap_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_ldap_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_ldap_port}"
  to_port     = "${var.server_ldap_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_smb_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_smb_port}"
  to_port     = "${var.server_smb_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_smb_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_smb_port}"
  to_port     = "${var.server_smb_port}"
  protocol    = "udp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_ldaps_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_ldaps_port}"
  to_port     = "${var.server_ldaps_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_ldapgc_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_gc_port}"
  to_port     = "${var.server_gc_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_gc_ssl_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_gcssl_port}"
  to_port     = "${var.server_gcssl_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_dfsr_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_dfsr_port}"
  to_port     = "${var.server_dfsr_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_adws_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_adws_port}"
  to_port     = "${var.server_adws_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_dcom_tcp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_tcpdynamic_low_port}"
  to_port     = "${var.server_tcpdynamic_high_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_client_cidr_blocks}"]

  security_group_id = "${aws_security_group.clients_security_group.id}"
}

resource "aws_security_group_rule" "allow_client_dcom_udp_inbound" {
  count       = "${length(var.allowed_inbound_client_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.server_tcpdynamic_low_port}"
  to_port     = "${var.server_tcpdynamic_high_port}"
  protocol    = "udp"
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

