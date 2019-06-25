# Create a VPC for the region associated with the AZ
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  
  tags {
    Name = "${var.env_level}-${var.product}-${var.environment}-vpc"
	  environment  = "${var.environment}"
    product = "${var.product}"
    role = "VPC"
  }
}