/*
  INTERNET GATEWAY
*/
# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
	  Name = "${var.env_level}-${var.environment}-igw"
	  environment = "${var.environment}"
    product = "${var.product}"
    role = "internet gateway"
  }
 }