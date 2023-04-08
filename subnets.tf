resource "aws_internet_gateway" "instance1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "subnet1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_subnet" "subnet1" {
  count = var.subnets_count
  cidr_block = "${cidrsubnet(aws_vpc.vpc1.cidr_block, var.subnets_size, count.index + 1)}"
  availability_zone = "${data.aws_availability_zones.availability_zone1.names[count.index]}"
  vpc_id = aws_vpc.vpc1.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "subnet1" {
  count = var.subnets_count
  subnet_id = aws_subnet.subnet1[count.index].id
  route_table_id = aws_route_table.subnet1.id
}

resource "aws_route" "subnet1" {
  route_table_id = aws_route_table.subnet1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.instance1.id
}

resource "aws_internet_gateway" "instance2" {
  vpc_id = aws_vpc.vpc2.id
  provider = aws.brazil
}

resource "aws_route_table" "subnet2" {
  vpc_id = aws_vpc.vpc2.id
  provider = aws.brazil
}

resource "aws_subnet" "subnet2" {
  count = var.subnets_count
  cidr_block = "${cidrsubnet(aws_vpc.vpc2.cidr_block, var.subnets_size, count.index + 1)}"
  availability_zone = data.aws_availability_zones.availability_zone2.names[count.index]
  provider = aws.brazil
  vpc_id = aws_vpc.vpc2.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "subnet2" {
  count = var.subnets_count
  provider = aws.brazil
  subnet_id = aws_subnet.subnet2[count.index].id
  route_table_id = aws_route_table.subnet2.id
}

resource "aws_route" "subnet2" {
  route_table_id = aws_route_table.subnet2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.instance2.id
  provider = aws.brazil
}