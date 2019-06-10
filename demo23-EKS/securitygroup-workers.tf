resource "aws_security_group" "eks_cluster_node" {
  name = "eks_cluster_node"
  description = "Security group for nodes in cluster"
  vpc_id = "${module.vpc.vpc_id}"

  egress{
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = "${
    map(
        "Name", "eks_cluster_node",
        "kubernetes.io/cluster/${var.eks_cluster_name}", "owned"
    )
  }"
}

resource "aws_security_group_rule" "perandr_eks_ingress_nodes" {
    description = "Allow node to comunicate each other"
    from_port = 0
    protocol = "-1"    
    security_group_id = "${aws_security_group.eks_cluster_node.id}"
    source_security_group_id = "${aws_security_group.eks_cluster_node.id}"
    to_port = 65535
    type = "ingress"
}

resource "aws_security_group_rule" "perandr_eks_ingress_cluster" {
    description = "Allow worker Kublets and pods to communicate with cluster control plane"
    from_port = 1025
    protocol = "tcp"    
    security_group_id = "${aws_security_group.eks_cluster_node.id}"
    source_security_group_id = "${aws_security_group.eks_cluster_node.id}"
    to_port = 65535
    type = "ingress"
}

