resource "aws_eip" "nat" {
  vpc   = true
  count             =  "${length(var.public_subnets)}"
  
  tags = {
        Name = "${var.Name}-nat-${format("%02d", count.index + 1)}"
        Environment = "${var.Environment}"
  }
  
  lifecycle { create_before_destroy = true }
}

resource "aws_nat_gateway" "nat" {
  count             =  "${length(var.public_subnets)}"
  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
  
  tags = {
        Name = "${var.Name}-nat-gw-${format("%02d", count.index + 1)}"
        Environment = "${var.Environment}"
    }
  
  lifecycle { create_before_destroy = true }
}
