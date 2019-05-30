provider "aws" {
  region = "eu-west-1"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["*ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

output "amis" {
  value = "${data.aws_ami.ubuntu.id}"
}
