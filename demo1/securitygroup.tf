data "aws_ip_ranges" "eu_ec2_ranges" {
    regions = ["eu-north-1", "eu-central-1"]
    services = ["ec2"]
}

resource "aws_security_group" "eu_in_traffic_sec_group" {
   name = "eu_in_traffic_sec_group"

   ingress {
       from_port = "443"
       to_port = "443"
       protocol = "tcp"
       cidr_blocks = ["${data.aws_ip_ranges.eu_ec2_ranges.cidr_blocks}"]
   }

   tags {
       CreateDate = "${data.aws_ip_ranges.eu_ec2_ranges.create_date}"
       SyncToken = "${data.aws_ip_ranges.eu_ec2_ranges.sync_token}"
   }
}
