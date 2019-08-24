##############################
#PRIVATE SUBNETS
##############################
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             =  "${length(var.private_subnets)}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  
  tags     = { 
    Name = "${var.Name}-${var.azs[count.index]}-private"
    Enviornment = "${var.Environment}"
    Product = "${var.Product}"
    Platform = "${var.Platform}"
    Terraform = "${var.Terraform}"
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  count   = "${length(var.private_subnets)}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.*.id[count.index]}"
  }

  tags   = { 
    Name = "${var.Name}.priv_route_table.${var.azs[count.index]}" 
    Enviornment = "${var.Environment}"
    Product = "${var.Product}"
    Platform = "${var.Platform}"
    Terraform = "${var.Terraform}"
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "private" {
  count              = "${length(var.private_subnets)}"
  subnet_id          = "${aws_subnet.private.*.id[count.index]}"
  route_table_id     = "${aws_route_table.private.*.id[count.index]}"
}