resource "aws_launch_configuration" "t2-launch-config" {
    name_prefix = "t2-launch-config"
    image_id = "${data.aws_ami.ubuntu_amis.image_id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.t2_micro_key.key_name}"
    security_groups = ["${aws_security_group.instance_sec_group.id}"]
    user_data = "#!/bin/bash\napt update\napt install -y nginx\nMY_IP=`ifconfig | grep 'inet 10' | awk '{ print $2 }' | cut -d ':' -f2` \n echo 'this is: ' $MY_IP > /var/www/html/index.html"
    
}

resource "aws_autoscaling_group" "t2-autoscaling-group" {
    name = "t2-autoscaling-group"
    vpc_zone_identifier = ["${aws_subnet.demo14-public-1.id}", "${aws_subnet.demo14-public-2.id}"]
    launch_configuration = "${aws_launch_configuration.t2-launch-config.name}"
    min_size = 1
    max_size = 3
    desired_capacity = 2
    health_check_grace_period = 300
    health_check_type = "ELB"
    load_balancers = ["${aws_elb.web-elb.name}"]
    force_delete = true

    tag {
        key = "Name"
        value = "ec2_instance_auto"
        propagate_at_launch = true
    }
}