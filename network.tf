module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name = local.resource_name
  tags = local.tags

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
}
