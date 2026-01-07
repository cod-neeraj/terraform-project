variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "az" {
  type = list(string)
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}


variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "docker_image" {
  type = string
}

variable "ecr_repo" {
  type = string
}
