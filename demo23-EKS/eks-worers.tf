data "aws_ami" "eks_worker" {
  # filter {  #     name = "name"  #     values = ["*eks-node-*"]  # }

  # most_recent = true  # owners = ["602401143452"] # Amazon

  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.perandr_kubernetes.version}-v*"]
  }

  # filter {
  #   name   = "name"
  #   values = ["*eks-worker-*"]
  # }

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
/etc/eks/bootstrap.sh '${var.eks_cluster_name}' --apiserver-endpoint '${aws_eks_cluster.perandr_kubernetes.endpoint}' --b64-cluster-ca '${aws_eks_cluster.perandr_kubernetes.certificate_authority.0.data}'
USERDATA
}

output "eks_user_data" {
  value = "${local.eks_user_data}"
}

# locals {
#   eks_user_data = <<USERDATA
# #!/bin/bash -xe

# CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
# CA_CERTIFICATE_FILE_PATH=$CA_CERTIFICATE_DIRECTORY/ca.crt
# mkdir -p $CA_CERTIFICATE_DIRECTORY
# echo "${aws_eks_cluster.perandr_kubernetes.certificate_authority.0.data}" | base64 -d >  $CA_CERTIFICATE_FILE_PATH
# INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
# sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.perandr_kubernetes.endpoint},g /var/lib/kubelet/kubeconfig
# sed -i s,CLUSTER_NAME,${var.eks_cluster_name},g /var/lib/kubelet/kubeconfig
# sed -i s,REGION,${var.AWS_REGION},g /etc/systemd/system/kubelet.service
# sed -i s,MAX_PODS,20,g /etc/systemd/system/kubelet.service
# sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.perandr_kubernetes.endpoint},g /etc/systemd/system/kubelet.service
# sed -i s,INTERNAL_IP,$INTERNAL_IP,g /etc/systemd/system/kubelet.service
# DNS_CLUSTER_IP=10.100.0.10
# if [[ $INTERNAL_IP == 10.* ]] ; then DNS_CLUSTER_IP=172.20.0.10; fi
# sed -i s,DNS_CLUSTER_IP,$DNS_CLUSTER_IP,g /etc/systemd/system/kubelet.service
# sed -i s,CERTIFICATE_AUTHORITY_FILE,$CA_CERTIFICATE_FILE_PATH,g /var/lib/kubelet/kubeconfig
# sed -i s,CLIENT_CA_FILE,$CA_CERTIFICATE_FILE_PATH,g  /etc/systemd/system/kubelet.service
# systemctl daemon-reload
# systemctl restart kubelet
# USERDATA
# }

resource "aws_launch_configuration" "eks_demo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.perandr_eks_node.name}"
  image_id                    = "${data.aws_ami.eks_worker.image_id}"
  instance_type               = "t2.small"
  name_prefix                 = "terraform_eks_perandr"
  security_groups             = ["${aws_security_group.eks_cluster_node.id}", "${aws_security_group.allow-ssh.id}"]
  key_name                    = "${aws_key_pair.t2_micro_key.key_name}"

  user_data = "${base64encode(local.eks_user_data)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_autoscaling" {
  name                 = "eks_autoscaling"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.eks_demo.id}"
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = ["${module.vpc.public_subnets}"]

  tags = [
    {
      key                 = "Name"
      value               = "terraform-eks"
      propagate_at_launch = true
    },
    {
      key                 = "kubernetes.io/cluster/${var.eks_cluster_name}"
      value               = "owned"
      propagate_at_launch = true
    },
  ]
}
