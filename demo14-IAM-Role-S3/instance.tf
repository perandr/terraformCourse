resource "aws_key_pair" "t2_micro_key"{
    key_name = "demo14-key"
    public_key = "${file("${var.PATH_TO_PUB_KEY}")}"
}
resource "aws_instance" "t2_micro" {
    ami = "${data.aws_ami.ubuntu_amis.id}"
    instance_type = "t2.micro"

    key_name = "${aws_key_pair.t2_micro_key.key_name}"
    subnet_id = "${aws_subnet.demo14-public-1.id}"
    # vpc_security_group_ids = ["${aws_security_group.demo14-sec-group.id}"]

    provisioner "remote-exec" {
        inline = [
            "pwd",
           "sudo apt update && sudo apt install -y python-pip python-dev && sudo pip install awscli",
           # "sudo ufw allow ssh",
           # "sudo ufw status verbose"
            "echo Hello world!"
        ]
    }

    connection {
        user = "ubuntu"
        private_key = "${file("${var.PATH_TO_PRIV_KEY}")}"
    }

    # iam_instance_profile = "${aws_iam_instance_profile.t2_micro_bucket_instance_profile.name}"

    iam_instance_profile = "${aws_iam_instance_profile.t2_micro_bucket_instance_profile.name}"
}

output "t2_micro_ip" {
  value = "${aws_instance.t2_micro.public_ip}"
}
