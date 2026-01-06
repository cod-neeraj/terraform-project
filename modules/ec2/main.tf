resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.app_sg_id]
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker
              
              docker login --username AWS --password-stdin ${var.ecr_repo}

              docker pull ${var.docker_image}
              docker run -d -p 8080:8080 ${var.docker_image}
              EOF

  tags = {
    Name = "${var.name}-ec2"
  }
}
