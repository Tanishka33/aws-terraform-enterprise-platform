locals {
  user_data = templatefile("${path.module}/userdata.sh", {
    environment = var.environment
    bucket_name = var.bucket_name
    aws_region  = var.aws_region
  })
}

resource "aws_instance" "server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  subnet_id = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = true

  user_data = local.user_data

  iam_instance_profile = var.instance_profile_name

  lifecycle {
  create_before_destroy = true

  ignore_changes = [
    tags
    ]
  }

  tags = {
    Name = "${var.environment}-server"
  }
}