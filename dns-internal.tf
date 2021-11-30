resource "aws_route53_zone" "internal" {
  name    = "internal"
  comment = "Supports internal DNS discovery of services"
  tags    = local.tags

  vpc {
    vpc_id = module.network.vpc_id
  }
}
