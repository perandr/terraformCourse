resource "aws_key_pair" "aws-t2_micro-key" {
    key_name = "aws-t2_micro-key"
    public_key = "${file("${var.PATH_TO_PUB_KEY}")}"
}

resource "aws_instance" "t2_micro" {
    ami = "${data.aws_ami.ubuntu_amis.id}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.demo9-pub-subnet.id}"
    key_name = "${aws_key_pair.aws-t2_micro-key.key_name}"

    # user_data = "${data.template_file.t2_micro_shell-script.rendered}"

    user_data = "${data.template_cloudinit_config.t2_micro_init_config.rendered}"

    tags{
        Name = "T2_Micro_terraform"
    }
}

resource "aws_ebs_volume" "demo9-ebs-volume-1" {
    availability_zone = "${var.demo9-availability-zone}"
    size = 20
    type = "gp2"
}

resource "aws_volume_attachment" "demo9-ebs-volume-1-attach" {
    device_name = "${var.DEVICE_NAME}"
    volume_id = "${aws_ebs_volume.demo9-ebs-volume-1.id}"
    instance_id = "${aws_instance.t2_micro.id}"
    skip_destroy = "true"
    depends_on = ["aws_instance.t2_micro"]
}



output "public_ip" {
    value = "ssh ubuntu@${aws_instance.t2_micro.public_ip} -i demo9-key"
}

