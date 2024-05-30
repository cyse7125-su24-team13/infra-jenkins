variable "aws_region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-09f0d8ab49ae0d9c9"
}

variable "instance_type" {
  description = "Instance type for the Jenkins instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
  default     = "test"
}

variable "private_key_path" {
  description = "path to private key"
  type        = string
  default     = "~/.ssh/test.pem"
}

# variable "domain_name" {
#   description = "Domain name for the SSL certificate"
#   type        = string
# }

# variable "email" {
#   description = "Email for Let's Encrypt SSL certificate"
#   type        = string
# }
