# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"

  # tags {
	#   Name = "${var.env_level}-${var.environment}-internet_route"
	#   environment = "${var.environment}"
  #   product = "${var.product}"
  #   role = "internet gateway"
  # }
}