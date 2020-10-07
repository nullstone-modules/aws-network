resource "aws_route53_zone" "internal" {
  name    = "internal"
  comment = "Supports internal DNS discovery of services"

  vpc {
    vpc_id = module.network.vpc_id
  }

  tags = {
    Stack       = var.stack_name
    Environment = var.env
    Block       = var.block_name
  }
}
