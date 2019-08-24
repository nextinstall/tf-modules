# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT CONTROL WHAT MGMT TRAFFIC CAN GO IN AND OUT OF A DOMAIN CONTROLLER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "mgmt_security_group" {
  description = "${var.env_level} ${var.product} MGMT ACCESS Security Group"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags {
    Name        = "${var.env_level}-${var.product}-mgmt-sg"
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
# CREATE THE SECURITY GROUP THAT CONTROL WHAT CLIENT TRAFFIC CAN GO IN TO A DOMAIN CONTROLLER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "clients_security_group" {
  description = "${var.env_level} ${var.product} CLIENT ACCESS Security Group"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags {
    Name        = "${var.env_level}-${var.product}-client-sg"
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
# CREATE THE SECURITY GROUP THAT CONTROLS OUTBOUND ALL
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "all_outbound_security_group" {
  description = "${var.env_level} ${var.product} ALLOW ALL OUTBOUND Security Group"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags {
    Name        = "${var.env_level}-${var.product}-allout-sg"
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
