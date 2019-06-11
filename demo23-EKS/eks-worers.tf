data "aws_ami" "eks_worker" {
    # filter {
    #     name = "name"
    #     values = ["*eks-node-*"]
    # }

    # most_recent = true
    # owners = ["602401143452"] # Amazon

    filter {
      name   = "name"
      values = ["amazon-eks-node-${aws_eks_cluster.perandr_kubernetes.version}-v*"]
    }

    most_recent = true
    owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

output "eks_worker-AMI" {
  value = "${data.aws_ami.eks_worker.image_id}"
}


locals {
  eks_user_data = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.perandr_kubernetes.endpoint}' --b64-cluster-ca '${aws_eks_cluster.perandr_kubernetes.certificate_authority.0.data}' '${var.eks_cluster_name}'
USERDATA
}


resource "aws_launch_configuration" "eks_demo" {
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.perandr_eks_node.name}"
  image_id = "${data.aws_ami.eks_worker.image_id}"
  instance_type = "t2.small"
  name_prefix = "terraform_eks_perandr"
  security_groups = ["${aws_security_group.eks_cluster_node.id}"]

  user_data = "${base64encode(local.eks_user_data)}"

  lifecycle{
      create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_autoscaling" {
    name = "eks_autoscaling"
    desired_capacity = 2
    launch_configuration = "${aws_launch_configuration.eks_demo.id}"
    max_size = 2
    min_size = 1
    vpc_zone_identifier = ["${module.vpc.public_subnets}"]

    tag{
        key = "Name"
        value = "terraform-eks"
        propagate_at_launch = true
    }
}
