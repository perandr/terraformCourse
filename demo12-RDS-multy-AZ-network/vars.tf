
variable "REGION" {
  default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable DB_USER_NAME {}
variable DB_USER_PASSWORD {}

variable "PATH_TO_PUB_KEY" {
    default = "demo12-key.pub"
}

variable "PATH_TO_PRIV_KEY" {
    default = "demo12-key"
}

variable "demo9-availability-zone" {
  default = "eu-west-1a"
}

variable "DEVICE_NAME" {
    default = "/dev/xvdh"
}

variable "base_cidr" {
description = "cidr for vpc" #this variable is utilized in the locals.tf
type = "string"
default = "10.0.0.0/24"
}

variable "max_subnets" {
description = "Maximum number of subnets which can be created for CIDR blocks calculation. Default to length of names argument"
default = "12"
}

variable "newbits" {
    default = "16"
}


variable "netnum_private_db" {
type = "string"
default = "9"
}