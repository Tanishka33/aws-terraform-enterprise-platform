resource "aws_security_group" "main" {
  name        = "${var.environment}-sg"
  description = "Security group for ${var.environment}"
  vpc_id      = var.vpc_id

# SSH
  ingress {
    description = "Allow SSH"

    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"

    cidr_blocks = ["223.185.39.156/32"]
  }

# HTTP
  ingress {
    description = "Allow HTTP"

    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

# OUTBOUND  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg"
  }
}