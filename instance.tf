resource "aws_instance" "instance1" {
  count = var.instances_count
  ami = data.aws_ami.ami1.image_id
  instance_type = "t3.micro"
  key_name = var.instance_key
  subnet_id = "${aws_subnet.subnet1.0.id}"
  vpc_security_group_ids = [aws_security_group.instance1["instances"].id]

  tags = {
    Name = "${var.project_name}-vm-${count.index}"
  }
}

resource "aws_instance" "instance2" {
  count = var.instances_count
  provider = aws.brazil
  ami = data.aws_ami.ami2.image_id
  instance_type = "t3.micro"
  key_name = var.instance_key
  subnet_id = "${aws_subnet.subnet2.0.id}"
  vpc_security_group_ids = [aws_security_group.instance2["instances"].id]

  tags = {
    Name = "${var.project_name}-vm-${count.index}"
  }
}