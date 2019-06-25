
variable "REGION" {
  default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}


variable "PATH_TO_PUB_KEY" {
    default = "demo9-key.pub"
}

variable "PATH_TO_PRIV_KEY" {
    default = "demo9-key"
}

variable "demo9-availability-zone" {
  default = "eu-west-1a"
}

variable "DEVICE_NAME" {
    default = "/dev/xvdh"
}