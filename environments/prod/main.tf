terraform {
  backend "s3" {}
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone

  environment = var.environment
}


module "security_group" {
  source = "../../modules/security-group"

  vpc_id     = module.vpc.vpc_id
  environment = var.environment

  ssh_port  = var.ssh_port
  http_port = var.http_port
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = var.app_bucket_name
  environment = var.environment
}

module "iam" {
  source = "../../modules/iam"

  environment = var.environment

  bucket_arn = module.s3.bucket_arn
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  subnet_id = module.vpc.public_subnet_id

  security_group_id = module.security_group.security_group_id

  instance_profile_name = module.iam.instance_profile_name

  environment = var.environment

  depends_on = [
    module.vpc,
    module.security_group,
    module.iam
  ]
}