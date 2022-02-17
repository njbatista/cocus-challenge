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
    Name    = "awslab-subnet-public"
  }
}

# Create Private Subnet
# terraform aws create subnet
resource "aws_subnet" "awslab-subnet-private" {
  vpc_id                   = aws_vpc.awslab-vpc.id
  cidr_block               = "${var.private-subnet-cidr}"
  availability_zone        = "eu-west-2b"
  map_public_ip_on_launch  = true

  tags      = {
    Name    = "awslab-subnet-private"
  }
}

# Use default routing table
# terraform aws default route table
resource "aws_default_route_table" "route-table" {
  default_route_table_id = aws_vpc.awslab-vpc.default_route_table_id 

  tags      = {
    Name    = "awslab-rt-private"
  }
}

# Create public routing table
# terraform aws default route table
resource "aws_route_table" "awslab-rt-internet" {
  vpc_id = aws_vpc.awslab-vpc.id

  route {
    cidr_block = "${var.route-cidr}"
    gateway_id = aws_internet_gateway.internet-gateway.id

  }

  tags = {
    Name = "awslab-rt-internet"
  }
}

# Associate Public Subnet to private route table
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id           = aws_subnet.awslab-subnet-public.id
  route_table_id      = aws_route_table.awslab-rt-internet.id
}

# Associate Private Subnet to "Default Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-route-table-association" {
  subnet_id           = aws_subnet.awslab-subnet-private.id
  route_table_id      = aws_default_route_table.route-table.id
}