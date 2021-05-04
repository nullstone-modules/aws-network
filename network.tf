module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"

  name = local.resource_name

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

  tags = data.ns_workspace.this.tags
}

resource "aws_security_group" "vpc_endpoints" {
  name   = "vpc-endpoints/${local.resource_name}"
  vpc_id = module.network.vpc_id
  tags   = data.ns_workspace.this.tags
}

resource "aws_security_group_rule" "allow_inside" {
  security_group_id = aws_security_group.vpc_endpoints.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = [var.cidr]
}

data "aws_vpc_endpoint_service" "ecr_api" {
  service = "ecr.api"
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id             = module.network.vpc_id
  service_name       = data.aws_vpc_endpoint_service.ecr_api.service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = module.network.private_subnets
}

data "aws_vpc_endpoint_service" "ecr_dkr" {
  service = "ecr.dkr"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id             = module.network.vpc_id
  service_name       = data.aws_vpc_endpoint_service.ecr_dkr.service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = module.network.private_subnets
}

data "aws_vpc_endpoint_service" "secretsmanager" {
  service = "secretsmanager"
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id             = module.network.vpc_id
  service_name       = data.aws_vpc_endpoint_service.secretsmanager.service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = module.network.private_subnets
}

data "aws_vpc_endpoint_service" "kms" {
  service = "kms"
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id             = module.network.vpc_id
  service_name       = data.aws_vpc_endpoint_service.kms.service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = module.network.private_subnets
}
