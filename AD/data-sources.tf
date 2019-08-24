# ---------------------------------------------------------------------------------------------------------------------
# Data Sources for all sub component resource builds
# ---------------------------------------------------------------------------------------------------------------------

  data "aws_vpc" "vpc" {
    tags {
      Environment = "${var.Environment}"
    }
  }

  data "aws_subnet_ids" "nets" {
    vpc_id = "${data.aws_vpc.vpc.id}"
    tags {
      Environment = "${var.Environment}"
    }
  }

  data "aws_subnet_ids" "elbnets" {
    vpc_id = "${data.aws_vpc.vpc.id}"
    tags {
      Environment = "ELB"
    }
  }
 
   data "aws_region" "current" {}