resource "aws_vpc" "this" {
  cidr_block           = var.vpccidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "routine-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "routine-igw" }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  for_each = toset(var.publicsubnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, index(var.publicsubnets, each.value))
  tags = { Name = "routine-public-${each.value}" }
}

resource "aws_subnet" "private" {
  for_each = toset(var.privatesubnets)
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value
  tags       = { Name = "routine-private-${each.value}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "routine-public-rt" }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
