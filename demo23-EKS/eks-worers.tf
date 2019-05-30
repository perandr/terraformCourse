data "aws_ami" "eks_worker" {
    filter {
        name = "name"
        values = ["eks-worker-*"]
    }

    most_recent = true
    owners = ["602401143452"] # Amazon
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
  instance_type = "t2.medium"
  name_prefix = "terraform_eks_perandr"
  security_groups = ["${aws_eks_cluster.perandr_kubernetes.id}"]
  user_data = "${base64encode(local.eks_user_data)}"

  lifecycle{
      create_before_destroy = true
  }
}
