resource "aws_vpc" "demo9-small-vpc" {
    cidr_block="10.0.0.0/16"
    enable_classiclink = "false"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    instance_tenancy="default"
}

resource "aws_subnet" "demo9-pub-subnet" {
    vpc_id = "${aws_vpc.demo9-small-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone="${var.demo9-availability-zone}"
}

resource "aws_internet_gateway" "demo9-small-vpc-gw" {
  vpc_id = "${aws_vpc.demo9-small-vpc.id}"
}


resource "aws_route_table" "demo9-route-table" {
    vpc_id = "${aws_vpc.demo9-small-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demo9-small-vpc-gw.id}"
    }
}

resource "aws_route_table_association" "demo9-route-table-assoc" {
    route_table_id = "${aws_route_table.demo9-route-table.id}"
    subnet_id = "${aws_subnet.demo9-pub-subnet.id}"
}

resource "aws_default_security_group" "demo9-vpc-sec-group" {
    vpc_id="${aws_vpc.demo9-small-vpc.id}"

    ingress {
        protocol  = "tcp"
        from_port = 22
        to_port   = 22
        cidr_blocks = ["213.159.247.126/32"] 
    }
    egress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

