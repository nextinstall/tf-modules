##############################
#PUBLIC SUBNETS
##############################
resource "aws_internet_gateway" "public" {
  vpc_id = "${var.vpc_id}"

  tags = { Name = "${var.Name}-igw" }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             = "${length(var.public_subnets)}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags      = { Name = "${var.Name}-${var.azs[count.index]}-public" }
  lifecycle { create_before_destroy = true }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             = "${length(var.public_subnets)}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags = { Name = "${var.Name}.pub_route_table.${var.azs[count.index]}" }
 
  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "public" {
  count             = "${length(var.public_subnets)}"
  subnet_id         = "${aws_subnet.public.*.id[count.index]}"
  route_table_id    = "${aws_route_table.public.*.id[count.index]}"
}