variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "PATH_TO_PRIV_KEY" {
    default = "demo14-key"
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "PATH_TO_PUB_KEY" {
    default = "demo14-key.pub"
}
variable "eks_cluster_name" {
    default = "perandr_eks_cluster"
    type = "string"
}


