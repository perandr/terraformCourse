resource "aws_vpc" "demo8-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"

    tags {
        Name = "demo8-vpc"
    }
}

resource "aws_subnet" "demo8-public-1" {
    vpc_id = "${aws_vpc.demo8-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

   tags {
       Name = "demo8-public-1"
   }
}

resource "aws_subnet" "demo8-public-2" {
    vpc_id = "${aws_vpc.demo8-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1b"

   tags {
       Name = "demo8-public-2"
   }
}

resource "aws_internet_gateway" "demo8-inet-gw" {
    vpc_id = "${aws_vpc.demo8-vpc.id}"
    tags {
        Name = "demo8-inet-gw"
    }
}

resource "aws_route_table" "demo8-route-table" {
   vpc_id = "${aws_vpc.demo8-vpc.id}"
   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.demo8-inet-gw.id}"
   }
   tags {
       Name = "demo8-route-table"
   }
}

resource "aws_route_table_association" "demo8-route-association" {
    subnet_id = "${aws_subnet.demo8-public-1.id}"
    route_table_id = "${aws_route_table.demo8-route-table.id}"
  
}


