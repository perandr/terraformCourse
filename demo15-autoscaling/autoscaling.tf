resource "aws_launch_configuration" "t2_mocro_launch_config" {
    name_prefix="t2_mocro_launch_config"
    image_id =  "${data.aws_ami.ubuntu_amis.id}"

    instance_type = "t2.micro"

    key_name = "${aws_key_pair.t2_micro_key.key_name}"
    security_groups=["${aws_default_security_group.demo14-sec-group-allow-ssh.id}"]
}

resource "aws_autoscaling_group" "t2_micro_autoscaling" {
    name = "t2_micro_autoscaling"
    vpc_zone_identifier = ["${aws_subnet.demo14-public-1.id}","${aws_subnet.demo14-public-2.id}"]
    launch_configuration = "${aws_launch_configuration.t2_mocro_launch_config.name}"
    min_size = 1
    max_size = 3
    desired_capacity =1
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true

    tag{
        key = "Name"
        value = "ec2_instance"
        propagate_at_launch = true
    }
}

