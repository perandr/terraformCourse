data "aws_ami" "ubuntu_amis" {
    owners = ["099720109477"] # Canonical
    most_recent = true

    filter {
        name = "name"
        values = ["*ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

}

output "amis" {
  value = "${data.aws_ami.ubuntu_amis.id}"
}
