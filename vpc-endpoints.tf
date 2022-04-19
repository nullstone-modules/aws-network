resource "aws_security_group" "vpc_endpoints" {
  name        = "vpc-endpoints/${local.resource_name}"
  vpc_id      = module.network.vpc_id
  tags        = local.tags
  description = "Security group attached to every VPC endpoint"
}

resource "aws_security_group_rule" "allow_inside" {
  security_group_id = aws_security_group.vpc_endpoints.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = [var.cidr]
  description       = "Enable VPC endpoints to access any port for any device on the network"
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
  tags               = local.tags

  count = var.enable_vpc_endpoints ? 1 : 0
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
  tags               = local.tags

  count = var.enable_vpc_endpoints ? 1 : 0
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
  tags               = local.tags

  count = var.enable_vpc_endpoints ? 1 : 0
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
  tags               = local.tags

  count = var.enable_vpc_endpoints ? 1 : 0
}
