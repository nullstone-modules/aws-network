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
