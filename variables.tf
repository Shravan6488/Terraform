variable "access_key" {}
variable "secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "region" {
  default = "ap-southeast-1"
}

variable "ami" {
    default = "ami-03221428e6676db69"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "test_subnet_cidr" {
    description = "CIDR for the test Public Subnet"
    default = "10.0.0.0/24"
}
