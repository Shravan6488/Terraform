provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

/*
  Create VPC
*/
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "TEST VPC"
    }
}

/*
  Create VPC IGW
*/
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}
/*
  Public Subnet Test
*/
resource "aws_subnet" "ap-southeast-1a-test" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.web_subnet_cidr}"
    availability_zone = "ap-southeast-1a"

    tags {
        Name = "Test"
    }
}

resource "aws_route_table" "ap-southeast-1a-test" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "test"
    }
}

resource "aws_route_table_association" "ap-southeast-1a-test" {
    subnet_id = "${aws_subnet.ap-southeast-1a-test.id}"
    route_table_id = "${aws_route_table.ap-southeast-1a-test.id}"
}

/*
  Test Servers in public test subnet
*/
resource "aws_security_group" "test" {
    name = "vpc_test"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.test_subnet_cidr}"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "Test SG"
    }
}

resource "aws_instance" "test01" {
    ami = "${var.ami}"
    availability_zone = "ap-southeast-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.test.id}"]
    subnet_id = "${aws_subnet.ap-southeast-1a-test.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "Test"
    }
}

resource "aws_eip" "test01" {
    instance = "${aws_instance.test01.id}"
    vpc = true
}

