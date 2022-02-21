# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.161.0.0/24"   # can use it as variable too (var.custom_vpc)
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "hub-vpc"
  }
}

# Subnets
resource "aws_subnet" "public_subnet" {
  count             = var.in_count
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  cidr_block        = element(cidrsubnets("10.161.0.0/24",2, 2, 2), count.index)

  tags = {
    "Name" = "hub-public-${count.index}"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "hub"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "hub-public-routeTable"
  }
}

# route associations public

resource "aws_route_table_association" "public_rt_association" {
  count          = var.in_count
  route_table_id = aws_route_table.main-public.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}

data "aws_availability_zones" "azs" {}

