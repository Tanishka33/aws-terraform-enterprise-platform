output "secret_path" {
  value = aws_ssm_parameter.developer_password_placeholder.name
}