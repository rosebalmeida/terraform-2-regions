resource "aws_security_group" "instance1" {
  for_each = toset(["instances", "database", "loadbalance"])
  name = "${var.project_name}-${each.key}-sg"
  description = "${var.project_name} - Security Group ${each.key}"
  vpc_id = aws_vpc.vpc1.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg-${each.key}"
  }
}

resource "aws_security_group_rule" "ssh1_all" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance1["instances"].id
}

resource "aws_security_group_rule" "http1" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.instance1["instances"].id
  source_security_group_id = aws_security_group.instance1["loadbalance"].id
}

resource "aws_security_group_rule" "database1" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  security_group_id = aws_security_group.instance1["database"].id
  source_security_group_id = aws_security_group.instance1["instances"].id
}

resource "aws_security_group_rule" "http1_all" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance1["loadbalance"].id
}

resource "aws_security_group" "instance2" {
  for_each = toset(["instances", "database", "loadbalance"])
  name = "${var.project_name}-${each.key}-sg"
  description = "${var.project_name} - Security Group ${each.key}"
  vpc_id = aws_vpc.vpc2.id
  provider = aws.brazil

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg-${each.key}"
  }
}

resource "aws_security_group_rule" "ssh2_all" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  provider = aws.brazil
  security_group_id = aws_security_group.instance2["instances"].id
}

resource "aws_security_group_rule" "http2" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  provider = aws.brazil
  security_group_id = aws_security_group.instance2["instances"].id
  source_security_group_id = aws_security_group.instance2["loadbalance"].id
}

resource "aws_security_group_rule" "database" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  provider = aws.brazil
  security_group_id = aws_security_group.instance2["database"].id
  source_security_group_id = aws_security_group.instance2["instances"].id
}

resource "aws_security_group_rule" "http2_all" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  provider = aws.brazil
  security_group_id = aws_security_group.instance2["loadbalance"].id
}