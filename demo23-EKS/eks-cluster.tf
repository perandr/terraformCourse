resource "aws_eks_cluster" "perandr_kubernetes" {
    name = "${var.cluster-name}"
    role_arn = "${aws_iam_role.perandr_eks.arn}"

    vpc_config{
        security_group_ids = ["${aws_security_group.perandr_eks.id}"]
        subnet_ids = ["${module.vpc.public_subnets}"]
    }

    depends_on = [
        "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSClusterPolicy",
        "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSServicePolicy",
    ]
}
