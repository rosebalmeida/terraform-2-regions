resource "aws_db_subnet_group" "instance1" {
  name = "mydb"
  subnet_ids = "${aws_subnet.subnet1.*.id}"

  tags = {
    Name = "${var.project_name}-db"
  }
}

resource "aws_db_instance" "instance1" {
  allocated_storage = 20
  backup_retention_period = 7
  db_subnet_group_name = aws_db_subnet_group.instance1.name
  engine = "postgres"
  engine_version = "12"
  identifier = "mydb"
  instance_class = "db.t3.micro"
  multi_az = false
  db_name = "mydb"
  password = "12345678"
  port = 5432
  publicly_accessible = true
  storage_encrypted = true
  storage_type = "gp2"
  username = "mydb"
  vpc_security_group_ids = [aws_security_group.instance1["database"].id]
  skip_final_snapshot = "true"
}

resource "aws_db_subnet_group" "instance2" {
  name = "mydb"
  subnet_ids = "${aws_subnet.subnet2.*.id}"
  provider = aws.brazil

  tags = {
    Name = "${var.project_name}-db"
  }
}

resource "aws_db_instance" "instance2" {
  provider = aws.brazil
  allocated_storage = 20
  backup_retention_period = 7
  db_subnet_group_name = aws_db_subnet_group.instance2.name
  engine = "postgres"
  engine_version = "12"
  identifier = "mydb"
  instance_class = "db.t3.micro"
  multi_az = false
  db_name = "mydb"
  password = "12345678"
  port = 5432
  publicly_accessible = true
  storage_encrypted = true
  storage_type = "gp2"
  username = "mydb"
  vpc_security_group_ids = [aws_security_group.instance2["database"].id]
  skip_final_snapshot = "true"
}