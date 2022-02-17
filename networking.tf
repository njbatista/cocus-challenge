# Create VPC
# terraform aws create vpc
resource "aws_vpc" "awslab-vpc" {
  cidr_block              =  "${var.vpc-cidr}"
  instance_tenancy        =  "default"
  enable_dns_hostnames    =  "true"

  tags      = {
    Name    = "awslab-vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.awslab-vpc.id

  tags      = {
    Name    = "internet gateway"
  }
}

# Create Public Subnet
# terraform aws create subnet
resource "aws_subnet" "awslab-subnet-public" {
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = "${var.public-subnet-cidr}"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet"
  }
}

# Create Private Subnet
# terraform aws create subnet
resource "aws_subnet" "awslab-subnet-private" {
  vpc_id                   = aws_vpc.awslab-vpc.id
  cidr_block               = "${var.public-subnet-cidr}"
  availability_zone        = "eu-west-2b"
  map_public_ip_on_launch  = true

  tags      = {
    Name    = "private subnet"
  }
}

# Use default routing table
# terraform aws default route table
resource "aws_default_route_table" "route-table" {
  default_route_table_id = aws_default_route_table.route-table.id
  vpc_id                 = aws_vpc.awslab-vpc.id

  route {
    cidr_block = "${var.route-cidr}"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}