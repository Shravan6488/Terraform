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
variable "data_volume1_size" {
  type = "string"
  default = "100"
}

variable "data_volume1_type" {
  type = "string"
  default = "gp2"
}

variable "data_volume1_device_name" {
  default = "/dev/sdc"
}
