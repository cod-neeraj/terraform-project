# -----------------------------
# Provider
# -----------------------------
provider "aws" {
  region = var.region
}

# -----------------------------
# VPC
# -----------------------------
module "vpc" {
  source = "../../modules/vpc"

  name                = var.name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

# -----------------------------
# Security Groups
# -----------------------------
module "security_groups" {
  source = "../../modules/security-groups"

  name     = var.name
  vpc_id   = module.vpc.vpc_id
  app_port = 8080
}

# -----------------------------
# IAM
# -----------------------------
module "iam" {
  source = "../../modules/iam"
  name   = var.name
}

# -----------------------------
# ALB
# -----------------------------
module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.security_groups.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
  app_port          = 8080
}

# -----------------------------
# EC2 (Backend App)
# -----------------------------
module "ec2" {
  source = "../../modules/ec2"


  name                 = var.name
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  private_subnet_ids    = module.vpc.private_subnet_ids
  app_sg_id            = module.security_groups.app_sg_id
  iam_instance_profile = module.iam.instance_profile_name
  docker_image         = var.docker_image
  ecr_repo             = var.ecr_repo
  region               = var.region

}


# -----------------------------
# Attach EC2 to ALB Target Group
# -----------------------------
resource "aws_lb_target_group_attachment" "app" {
  count = length(module.ec2.instance_ids)

  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_ids[count.index]
  port             = 8080
}

