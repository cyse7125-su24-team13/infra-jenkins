terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.aws_vpc_tags_name
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = var.jenkins_subnet_tags
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = var.aws_internet_gateway_tags_name
  }
}

resource "aws_route_table" "jenkins_route_table" {
  vpc_id = aws_vpc.jenkins_vpc.id
  route {
    cidr_block = var.aws_route_table_cidr_block
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }
  tags = {
    Name = var.aws_route_table_tags_name
  }
}

resource "aws_route_table_association" "jenkins_route_table_assoc" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.jenkins_vpc.id
  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidrblocks
  }
  ingress {
    from_port   = var.ingress1_from_port
    to_port     = var.ingress1_to_port
    protocol    = var.ingress1_protocol
    cidr_blocks = var.ingress1_cidrblocks
  }
  ingress {
    from_port   = var.ingress2_from_port
    to_port     = var.ingress2_to_port
    protocol    = var.ingress2_protocol
    cidr_blocks = var.ingress2_cidrblocks
  }
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidrblocks
  }
  tags = {
    Name = var.aws_security_group_tags
  }
}


resource "aws_instance" "jenkins_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.aws_instance_tags
  }

  provisioner "file" {
    source      = "scripts/setup.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = var.file_user
      private_key = file(var.private_key_path)
      host        = aws_instance.jenkins_instance.public_ip
    }
  }

  provisioner "remote-exec" {
    script = "scripts/setup.sh"

    connection {
      type        = "ssh"
      user        = var.remote-exec_user
      private_key = file(var.private_key_path)
      host        = aws_instance.jenkins_instance.public_ip
    }
  }

  depends_on = [
    aws_security_group.jenkins_sg
  ]

}

data "aws_eip" "existing_eip" {
  filter {
    name   = var.aws_eip_name
    values = var.aws_eip_values
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_instance.id
  allocation_id = data.aws_eip.existing_eip.id
}

resource "null_resource" "run_certbot" {
  triggers = {
    instance_id = aws_instance.jenkins_instance.id
    public_ip   = aws_instance.jenkins_instance.public_ip
  }

  depends_on = [aws_eip_association.eip_assoc]

  provisioner "remote-exec" {
    inline = var.cert_bot_command

    connection {
      type        = "ssh"
      user        = var.remote-exec-user1
      private_key = file(var.private_key_path)
      host        = data.aws_eip.existing_eip.public_ip
    }
  }
}
