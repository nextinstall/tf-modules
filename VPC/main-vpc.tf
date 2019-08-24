provider "aws"{
    region = "us-east-1"
}

resource "aws_vpc" "vpc"{
    cidr_block = "${var.cidr}"
    enable_dns_support   = true
    enable_dns_hostnames = true
  
    tags = {
        Name = "${var.Environment}-${var.Name}-vpc"
        Environment = "${var.Environment}"
        Product = "${var.Product}"
        Platform = "${var.Platform}"
        Terraform = "${var.Terraform}"
    }
}