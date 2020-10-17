module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"

  name = "${var.stack_name}-${var.env}-${var.block_name}"

  cidr = var.cidr

  azs             = data.aws_availability_zones.this.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  intra_subnets   = var.intra_subnets

  enable_ipv6          = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_s3_endpoint             = true
  enable_ecr_api_endpoint        = true
  enable_ecr_dkr_endpoint        = true
  enable_ecs_endpoint            = true
  enable_secretsmanager_endpoint = true
  enable_ssm_endpoint            = true
  enable_kms_endpoint            = true

  tags = {
    Stack       = var.stack_name
    Environment = var.env
  }

  vpc_tags = {
    Stack       = var.stack_name
    Environment = var.env
    Block       = var.block_name
  }
}
