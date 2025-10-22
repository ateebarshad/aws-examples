provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "myvpc" }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = { Name = "myigw" }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.16.0.0/20"
  map_public_ip_on_launch = true
  tags                    = { Name = "mysubnet" }
}

data "aws_route_table" "main" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.my_vpc.id]
  }
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

resource "aws_route" "default_route" {
  route_table_id         = data.aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = data.aws_route_table.main.id
}

output "vpc_id"        { value = aws_vpc.my_vpc.id }
output "subnet_id"     { value = aws_subnet.my_subnet.id }
output "igw_id"        { value = aws_internet_gateway.my_igw.id }
output "route_table_id"{ value = data.aws_route_table.main.id }
