resource "aws_iam_role" "eks_cluster_role" {
    name = "eks_cluster_role"
    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam:aws:policy/AmazonEKSClusterPolicy"
    role = "${aws_iam_role.eks_cluster_role.name}"
}
resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment.perandr_eks_AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam:aws:policy/AmazonEKSServicePolicy"
    role = "${aws_iam_role.eks_cluster_role.name}"
}