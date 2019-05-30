module "consul" {
  source = "github.com/wardviaene/terraform-consul-module.git"
  key_name = "${aws_key_pair.ec2_micro_key.key_name}"
  key_path = "${var.PATH_TO_PRIV_KEY}"
  subnets={
      "0" = "subnet-651e0c1d"
      "1" = "subnet-34a69b7e"
      "2" = "subnet-85a053ec"
  }
  instance_type = "${var.EC2_INSTANCE}"
  servers = 2

  vpc_id="vpc-f8e01291"
  region ="${var.AWS_REGION}"
  ami = "${var.AMIS}"
}

output "consul-output" {
  value = "${module.consul.server_address}"
}

