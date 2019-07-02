resource "aws_elb" "web-elb" {
    name = "web-elb"
    # availability_zones = ["eu-west-1a", "eu-west-1b"]
    subnets = ["${aws_subnet.demo14-public-1.id}", "${aws_subnet.demo14-public-2.id}"]
    security_groups = ["${aws_security_group.elb_sec_group.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }
    cross_zone_load_balancing = true
    idle_timeout = 120
    connection_draining = true
    connection_draining_timeout = 120

}

output "ELB host name " {
  value = "${aws_elb.web-elb.dns_name}"
}