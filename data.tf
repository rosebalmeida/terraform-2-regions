data "aws_availability_zones" "availability_zone1" {
}

data "aws_ami" "ami1" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-hvm-2.0.*-x86_64-gp2"]
  }
}

data "aws_availability_zones" "availability_zone2" {
    provider = aws.brazil
}

data "aws_ami" "ami2" {
  most_recent = true
  owners = ["amazon"]
  provider = aws.brazil

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-hvm-2.0.*-x86_64-gp2"]
  }
}