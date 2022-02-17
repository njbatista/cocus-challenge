# Create Security Group for the Public subnet
# terraform aws create security group
resource "aws_security_group" "public-security-group" {
  name        = "Public Security Group"
  description = "Enable HTTP/HTTPS/ICMP/SSH"
  vpc_id      = aws_vpc.awslab-vpc.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ICMP Access"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "public-security-group"
  }
}

# Create Security Group for the Private subnet
# terraform aws create security group
resource "aws_security_group" "private-security-group" {
  name        = "Private Security Group"
  description = "Enable Database,ICMP,SSH"
  vpc_id      = aws_vpc.awslab-vpc.id

  ingress {
    description      = "Database Access"
    from_port        = 3110
    to_port          = 3110
    protocol         = "tcp"
    cidr_blocks      = ["172.16.1.0/24"]
  }

  ingress {
    description      = "ICMP Access"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["172.16.1.0/24"]
  }

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["172.16.1.0/24"]
  }

  tags   = {
    Name = "private-security-group"
  }
}
