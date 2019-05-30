resource "aws_default_security_group" "demo8-sec-group-allow-ssh" {
   vpc_id = "${aws_vpc.demo8-vpc.id}"
#    description = " Security group to open SSH port"

   ingress {
       cidr_blocks = ["213.159.247.126/32"]
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

# resource "aws_security_group_rule" "nademo8-sec-group-allow_ssh" {
#     description ="Allow ssh from sec group rule"
#   type            = "ingress"
#   from_port       = 0
#   to_port         = 65535
#   protocol        = "tcp"
#   # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
#  cidr_blocks = ["213.159.247.126/32"]
#  security_group_id="${aws_security_group.demo8-sec-group.id}"
# }
