variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}


variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "az" {
  type = list(string)
}

variable "public_subnet_cidr" {
  type = list(string)
}

