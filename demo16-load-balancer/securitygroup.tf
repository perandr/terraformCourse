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
#         from_port       = 0
#         to_port         = 0
#         protocol        = "-1"
#         cidr_blocks     = ["0.0.0.0/0"]
#   }

#   tags {
#       Name = "allow_ssh"
#   }
# }

resource "aws_security_group" "instance_sec_group" {
   vpc_id = "${aws_vpc.demo14-vpc.id}"
#    description = " Security group to open SSH port"
    name = "instance_sec_group"
   ingress {
       cidr_blocks = ["0.0.0.0/0"]
       from_port = 22
       to_port = 22
       protocol = "tcp"
   }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        # cidr_blocks = ["0.0.0.0/0"]
        
        security_groups = ["${aws_security_group.elb_sec_group.id}"]
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

resource "aws_security_group" "elb_sec_group"{
    vpc_id = "${aws_vpc.demo14-vpc.id}" 
    name = "elb_sec_group"
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "elb"
    }
}