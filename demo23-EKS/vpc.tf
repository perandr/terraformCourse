module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "1.66.0"
    name ="perandr_vpc"
    cidr = "10.0.0.0/16"

    azs = ["${slice(data.aws_availability_zones.available.name, 0, 3)}"]
    public_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
    private_subnets = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]

    enable_nat_gateway = false
    enable_vpn_gateway = false

    tags = "${
        map(
        "Name", "demo23-perandr-eks",
        "kubernetes.io/cluster/${var.cluster-name}", "shared",
        ) 
    }"
}

data "aws_availability_zones" "available" {}
