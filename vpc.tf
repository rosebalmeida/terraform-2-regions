resource "aws_vpc" "vpc1" {
  cidr_block = var.range_ip
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_vpc" "vpc2" {
  cidr_block = var.range_ip
  enable_dns_hostnames = true
  enable_dns_support = true
  provider = aws.brazil

  tags = {
    Name = "${var.project_name}-vpc"
  }
}