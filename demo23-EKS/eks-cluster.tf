resource "aws_eks_cluster" "perandr_kubernetes" {
    name = "${var.eks_cluster_name}"
    role_arn = "${aws_iam_role.eks_cluster_role.arn}"

    vpc_config{
        security_group_ids = ["${aws_security_group.eks_cluster.id}"]
        subnet_ids = ["${module.vpc.public_subnets}"]
    }

    depends_on = [
        "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSClusterPolicy",
        "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSServicePolicy",
    ]
    
}
