provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "Enterprise-Platform"
    }
  }
}

provider "aws" {
  alias  = "dr"
  region = var.dr_region

  default_tags {
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Enterprise-Platform"
    Owner       = "Tanushka"
    CostCenter  = "DevOps"
  }
}
}

provider "aws" {
  alias  = "cross_account"
  region = "ap-south-1"

  assume_role {
    role_arn = "arn:aws:iam::357651219804:role/TerraformCrossAccountRole"
  }
}