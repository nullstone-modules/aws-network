resource "aws_vpc" "this" {
  count = 1

  #bridgecrew:skip=BC_AWS_LOGGING_9:VPC Flow Logs are expensive and can be added with an additional Nullstone block
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  tags                             = var.tags
}

resource "aws_default_security_group" "this" {
  count = 1

  vpc_id = aws_vpc.this[count.index].id
  tags   = merge({ "Name" = "default" }, var.tags)
}
