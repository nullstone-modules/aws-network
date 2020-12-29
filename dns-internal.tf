resource "aws_route53_zone" "internal" {
  name    = "internal"
  comment = "Supports internal DNS discovery of services"

  vpc {
    vpc_id = module.network.vpc_id
  }

  tags = data.ns_workspace.this.tags
}
