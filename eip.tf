resource "aws_eip" "test" {
  vpc = true
}

resource "aws_eip_association" "test" {
  instance_id   = "${module.test.server_id}"
  allocation_id = "${aws_eip.test.id}"
}
