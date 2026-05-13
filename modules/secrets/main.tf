resource "aws_ssm_parameter" "developer_password_placeholder" {
  name = "/${var.environment}/developer-user-password"

  type = "SecureString"

  value = "INITIAL_PASSWORD_TO_BE_UPDATED_MANUALLY"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "IAM Onboarding Secret"
  }

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      value
    ]
  }
}