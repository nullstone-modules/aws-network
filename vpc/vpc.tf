resource "aws_vpc" "this" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  tags                             = var.tags

  count = 1
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this[count.index].id
  tags   = merge({ "Name" = "default" }, var.tags)

  count = 1
}