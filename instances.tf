#Creates tls private key
# terraform tls private key
resource "tls_private_key" "private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#Creates public key
# terraform aws key pair
resource "aws_key_pair" "public-key" {
  key_name   = "myKey"
  public_key = tls_private_key.private-key.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.private-key.private_key_pem}' > ./myKey.pem"
  }
}

# Create Amazon Linux 2 EC2 Instance for webserver
# terraform aws instance
resource "aws_instance" "webserver-ec2-instance" {
  ami                         = "${var.AMI}"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public-key.id
  vpc_security_group_ids      = [aws_security_group.public-security-group.id]
  subnet_id                   = aws_subnet.awslab-subnet-public.id
  associate_public_ip_address = true
  user_data                   = "${file("install_apache.sh")}"

  tags = {
    Name = "Webserver EC2 Instance"
  }
 
}
# Create Amazon Linux 2 EC2 Instance for Database
# terraform aws instance
resource "aws_instance" "database-ec2-instance" {
  ami                         = "${var.AMI}"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public-key.id
  vpc_security_group_ids      = [aws_security_group.private-security-group.id]
  subnet_id                   = aws_subnet.awslab-subnet-private.id
  associate_public_ip_address = false

  tags = {
    Name = "Database server EC2 Instance"
  }
}