# Create a subnet for the AZ within the regional VPC
resource "aws_subnet" "main" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "10.0.${count.index}.0/24"

  tags {
    Name = "${var.env_level}-${var.environment}-${element(var.availability_zones, count.index)}-subnet"
		environment  = "${var.environment}"
    product = "${var.product}"
    role = "SUBNET"
    }

}