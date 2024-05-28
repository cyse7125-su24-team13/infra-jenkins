provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "jenkins-vpc"
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "jenkins-subnet"
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = "jenkins-igw"
  }
}

resource "aws_route_table" "jenkins_route_table" {
  vpc_id = aws_vpc.jenkins_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }
  tags = {
    Name = "jenkins-route-table"
  }
}

resource "aws_route_table_association" "jenkins_route_table_assoc" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.jenkins_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_eip" "jenkins_eip" {
  vpc = true
}

resource "aws_instance" "jenkins_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "jenkins-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      # "sudo certbot --nginx -d ${var.domain_name} --non-interactive --agree-tos -m ${var.email}"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = aws_instance.jenkins_instance.public_ip
    }
  }
  depends_on = [aws_security_group.jenkins_sg]
}

resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.jenkins_instance.id
  allocation_id = aws_eip.jenkins_eip.id
}

