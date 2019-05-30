# nat gw
resource "aws_eip" "demo7-nat" {
  vpc = true
}

resource "aws_nat_gateway" "demo7-nat-gw" {
    allocation_id = "${aws_eip.demo7-nat.id}"
    subnet_id = "${aws_subnet.demo-7-public-1.id}"
    #depends_on = ["${aws_internet_gateway.demo-7-gw.id}"]
}

# VPC setup NAT
resource "aws_route_table" "demo7-private" {
  vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.demo7-nat-gw.id}"
  }
  tags = {
      Name = "demo7-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "demo7-private-1-a" {
  subnet_id = "${aws_subnet.demo-7-private-1.id}"
  route_table_id = "${aws_route_table.demo7-private.id}"
}

resource "aws_route_table_association" "demo7-private-2-a" {
  subnet_id = "${aws_subnet.demo-7-private-2.id}"
  route_table_id = "${aws_route_table.demo7-private.id}"
}

resource "aws_route_table_association" "demo7-private-3-a" {
  subnet_id = "${aws_subnet.demo-7-private-3.id}"
  route_table_id = "${aws_route_table.demo7-private.id}"
}
