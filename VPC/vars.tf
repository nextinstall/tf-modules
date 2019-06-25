variable "environment" {
 description = "Environment to target"
  default = ""
}

variable "product" {
 description = "Application context of resource: IE AD"
  default = ""
}

variable "env_level" {
  description = "Environment leve: P0 (PROD), P1 (STAGE), P2 (TEST), P3 (DEV)"
  default = ""
}

variable "platform" {
  description = "Platform: Windows, Linux, AWS, other"
  default = ""
}

variable "role" {
  description = "Function/Role: VPC, System, App"
  default = ""
}


variable "availability_zones" {
  description = "Regional Availability Zones"
  type = "list"
  default = []
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}