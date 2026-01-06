variable "name" {
  description = "Name prefix"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "app_sg_id" {
  description = "Security group for backend app"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "docker_image" {
  description = "Docker image URI (ECR)"
  type        = string
}

variable "ecr_repo" {
  description = "ECR repository URI"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
