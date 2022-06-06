#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "mtalkz" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-mtalkz-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "mtalkz" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.mtalkz.id

  tags = tomap({
    "Name"                                      = "terraform-eks-mtalkz-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "mtalkz" {
  vpc_id = aws_vpc.mtalkz.id

  tags = {
    Name = "terraform-eks-mtalkz"
  }
}

resource "aws_route_table" "mtalkz" {
  vpc_id = aws_vpc.mtalkz.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mtalkz.id
  }
}

resource "aws_route_table_association" "mtalkz" {
  count = 2

  subnet_id      = aws_subnet.mtalkz.*.id[count.index]
  route_table_id = aws_route_table.mtalkz.id
}
