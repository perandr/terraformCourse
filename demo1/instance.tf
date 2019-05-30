resource "aws_key_pair" "ec2_micro_key"{
    key_name = "ec2_micro_key"
    public_key = "${file("${var.PATH_TO_PUB_KEY}")}"
}

resource "aws_instance" "ec2_micro" {
    ami = "${lookup(var.AMIS, "${var.AWS_REGION}-${var.image_os}")}"
    instance_type = "${var.EC2_INSTANCE}"
    key_name = "${aws_key_pair.ec2_micro_key.key_name}"

    provisioner "file" {
        source = "installer.sh"
        destination = "/tmp/installer.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/installer.sh",
            "sudo /tmp/installer.sh"
        ]
    }

    connection {
        user = "${var.INSTANCE_USER_NAME}"
        private_key = "${file("${var.PATH_TO_PRIV_KEY}")}"
    }
    provisioner "local-exec" {
        command = "echo ${aws_instance.ec2_micro.private_ip}"
    }
}

output "ip" {
    value = "${aws_instance.ec2_micro.public_ip}"
}


