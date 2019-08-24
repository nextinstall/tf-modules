variable "aws_region" {
  description = "AWS region"
  default ="us-east-1"
}

variable "vpc_id" {
  default = ""
}

variable "nat_gateways" {
  default = ""
}

variable "Name" {
  default = ""
}

variable "cidr" {
  default = "10.1.1.0/24"
}

variable "azs" {
  default =   ["us-east-1a", "us-east-1b", "us-east-1c"]
  
}

variable "private_subnets" {
  default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  
}

variable "public_subnets" {
  default = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
}

variable "Terraform" {
    default = "true"
}    

variable "Environment"{
    default = ""
}
  
variable "Product"{
    default = ""
}      
variable "Platform"{
    default = ""
}

variable "enable_nat_gateway" {
  default = "false"
}

variable "enable_vpn_gateway" {
    default = "false"
}

