variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    default = "eu-north-1"
}

variable "AMI_ID" {
    default = "ami-5e9c1520"
}

variable "image_os" {
    default = "ubuntu"
}
variable "AMIS" {
    type = "map"
    default = {
        eu-north-1-ubuntu = "ami-5e9c1520"
        us-west-2-ubuntu = "ami-06b94666"
    }
}
variable "EC2_INSTANCE" {
    default = "t3.micro"
}

variable "INSTANCE_USER_NAME" {
    default = "ubuntu"
}
variable "PATH_TO_PRIV_KEY" {
    default = "t3_micro_priv_key"
}

variable "PATH_TO_PUB_KEY" {
    default = "t3_micro_pub_key.pub"
}