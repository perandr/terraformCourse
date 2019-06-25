resource "aws_route53_zone" "perandr-zone" {
    name = "aws.perandr.top"
}

resource "aws_route53_record" "perandr-record" {
    zone_id = "${aws_route53_zone.perandr-zone.zone_id}"
    name = "aws.perandr.top"
    type = "A"
    ttl = "300"
    records=["${aws_instance.t2_micro.public_ip}"]
}

output "ns-servers" {
  value = "${aws_route53_zone.perandr-zone.name_servers}"
}

