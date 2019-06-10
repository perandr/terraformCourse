resource "aws_security_group" "eks_cluster" {
  name = "eks_cluster"
  description = "Cluster communication with worker nodes"
  vpc_id = "${module.vpc.vpc_id}"

  egress{
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  tags{
    Name = "eks_cluster"
  }
}

resource "aws_security_group_rule" "allow-ingress-node-https" {
  description = "Allow pods to communicate with cluster API Server"
  from_port = 443
  protocol = "tcp"
  to_port = 443
  security_group_id = "${aws_security_group.eks_cluster.id}"
  type = "ingress"
  cidr_blocks = ["${local.workstation-external-cidr}"]
}
resource "aws_security_group" "allow-ssh" {
    vpc_id = "${module.vpc.vpc_id}"
    name = "allow-ssh"
    description = " Security group to open SSH port"


   ingress {
       cidr_blocks = ["0.0.0.0/0"]
       from_port = 22
       to_port = 22
       protocol = "tcp"
   }

    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }
    tags {
      Name = "allow_ssh"
    }
}


# resource "aws_default_security_group" "demo14-sec-group-allow-ssh" {
#    vpc_id = "${aws_vpc.demo14-vpc.id}"
# #    description = " Security group to open SSH port"

#    ingress {
#        cidr_blocks = ["0.0.0.0/0"]
#        from_port = 22
#        to_port = 22
#        protocol = "tcp"
#    }

#     egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
#   tags {
#       Name = "allow_ssh"
#   }
# }

# resource "aws_security_group_rule" "nademo14-sec-group-allow_ssh" {
#     description ="Allow ssh from sec group rule"
#   type            = "ingress"
#   from_port       = 0
#   to_port         = 65535
#   protocol        = "tcp"
#   # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
#  cidr_blocks = ["213.159.247.126/32"]
#  security_group_id="${aws_security_group.demo14-sec-group.id}"
# }
