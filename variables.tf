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

variable "aws_profile" {
  type = string
  default = ""
}

variable "aws_vpc_tags_name" {
  type = string
  default = ""
}
variable "jenkins_subnet_tags" {
  type = string
  default = ""
}
variable "aws_internet_gateway_tags_name" {
  type = string
  default = ""
}
variable "aws_route_table_cidr_block" {
  type = string
  default = ""
}
variable "aws_route_table_tags_name" {
  type = string
  default = ""
}

variable "ingress_from_port" {
  type = number
  default = 0
}

variable "ingress_to_port" {
  type = number
  default = 0
}
variable "ingress_protocol" {
  type = string
  default = ""
}
variable "ingress_cidrblocks" {
  type = list(string)
  default = [ "" ]
}

variable "ingress1_from_port" {
  type = number
  default = 0
}

variable "ingress1_to_port" {
  type = number
  default = 0
}
variable "ingress1_protocol" {
  type = string
  default = ""
}
variable "ingress1_cidrblocks" {
  type = list(string)
  default = [ "" ]
}

variable "ingress2_from_port" {
  type = number
  default = 0
}
variable "ingress2_to_port" {
  type = number
  default = 0
}
variable "ingress2_protocol" {
  type = string
  default = ""
}
variable "ingress2_cidrblocks" {
  type = list(string)
  default = [ "" ]
}

variable "egress_from_port" {
  type = number
  default = 0
}

variable "egress_to_port" {
  type = number
  default = 0
}
variable "egress_protocol" {
  type = string
  default = ""
}
variable "egress_cidrblocks" {
  type = list(string)
  default = [ "" ]
}
variable "aws_security_group_tags" {
  type = string
  default = ""
}
variable "aws_instance_tags" {
  type = string
  default = ""
}
variable "file_user" {
  type = string
  default = ""
}
variable "remote-exec_user" {
  type = string
  default = ""
}
variable "aws_eip_name" {
  type = string
  default = ""
}
variable "aws_eip_values" {
  type = list(string)
  default = [""]
}
variable "cert_bot_command" {
  type = list(string)
  default = [ "" ]
}
variable "remote-exec-user1" {
  type = string
  default = ""
}