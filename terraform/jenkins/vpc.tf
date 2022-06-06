//Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "mtalkz-vpc"
    Environment = "${var.environment_tag}"
  }
}

//Creating Subnets
resource "aws_subnet" "subnet-1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mtalkz-sunbet"
    Environment = "${var.environment_tag}"
  }
}

//Creating Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "mtalkz-igw"
  }
}

// Creating Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {

gateway_id = aws_internet_gateway.gw.id
    cidr_block = "0.0.0.0/0"
  }

    tags = {
    Name = "mtalkz-rtb"
  }
}

// Route Table Association
resource "aws_route_table_association" "route-association" {
  subnet_id      = aws_subnet.subnet-1a.id
  route_table_id = aws_route_table.route_table.id
}

