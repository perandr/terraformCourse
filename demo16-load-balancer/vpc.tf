resource "aws_vpc" "demo14-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"

    tags {
        Name = "demo14-vpc"
    }
}

resource "aws_subnet" "demo14-public-1" {
    vpc_id = "${aws_vpc.demo14-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

   tags {
       Name = "demo14-public-1"
   }
}

resource "aws_subnet" "demo14-public-2" {
    vpc_id = "${aws_vpc.demo14-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1b"

   tags {
       Name = "demo14-public-2"
   }
}

resource "aws_internet_gateway" "demo14-inet-gw" {
    vpc_id = "${aws_vpc.demo14-vpc.id}"
    tags {
        Name = "demo14-inet-gw"
    }
}

resource "aws_route_table" "demo14-route-table" {
   vpc_id = "${aws_vpc.demo14-vpc.id}"
   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.demo14-inet-gw.id}"
   }
   tags {
       Name = "demo14-route-table"
   }
}

resource "aws_route_table_association" "demo14-route1-association" {
    subnet_id = "${aws_subnet.demo14-public-1.id}"
    route_table_id = "${aws_route_table.demo14-route-table.id}"
  
}

resource "aws_route_table_association" "demo14-route2-association" {
    subnet_id = "${aws_subnet.demo14-public-2.id}"
    route_table_id = "${aws_route_table.demo14-route-table.id}"
  
}

