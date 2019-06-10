resource "aws_iam_role" "eks_node_role" {
    name = "eks_node_role"
    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "perandr_eks_node_AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam:aws:policy/AmazonEKSWorkerNodePolicy"
    role = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_role_policy_attachment" "perandr_eks_node_AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam:aws:policy/AmazonEKS_CNI_Policy"
    role = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_role_policy_attachment" "perandr_eks_node_AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam:aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = "${aws_iam_role.eks_node_role.name}"
}

resource "aws_iam_instance_profile" "perandr_eks_node"{
    name = "perandr_eks_node"
    role = "${aws_iam_role.eks_node_role.name}"
}