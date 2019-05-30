resource "aws_vpc" "terraform_demo_7_vpc"{
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "terraform_demo_7_vpc"
    }
}

#Sbunets
resource "aws_subnet" "demo-7-public-1"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

    tags {
        Name = "demo-7-public-1"
    }
}

resource "aws_subnet" "demo-7-public-2"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1b"

    tags {
        Name = "demo-7-public-2"
    }
}

resource "aws_subnet" "demo-7-public-3"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1c"

    tags {
        Name = "demo-7-public-3"
    }
}

resource "aws_subnet" "demo-7-private-1"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1a"

    tags {
        Name = "demo-7-private-1"
    }
}
resource "aws_subnet" "demo-7-private-2"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1b"

    tags {
        Name = "demo-7-private-2"
    }
}
resource "aws_subnet" "demo-7-private-3"{
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1c"

    tags {
        Name = "demo-7-private-3"
    }
}

#Internet GW
resource "aws_internet_gateway" "demo-7-gw" {
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"
    tags = {
        Name = "demo-7-gw"
    }
}

#Route tables
resource "aws_route_table" "demo-7-public" {
    vpc_id = "${aws_vpc.terraform_demo_7_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demo-7-gw.id}"
    }    

    tags {
        Name = "demo-7-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "demo-7-public-1-a" {
    subnet_id = "${aws_subnet.demo-7-public-1.id}"
    route_table_id = "${aws_route_table.demo-7-public.id}"
}
resource "aws_route_table_association" "demo-7-public-2-a" {
    subnet_id = "${aws_subnet.demo-7-public-2.id}"
    route_table_id = "${aws_route_table.demo-7-public.id}"
}
resource "aws_route_table_association" "demo-7-public-3-a" {
    subnet_id = "${aws_subnet.demo-7-public-3.id}"
    route_table_id = "${aws_route_table.demo-7-public.id}"
}