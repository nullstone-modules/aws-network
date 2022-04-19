resource "aws_internet_gateway" "this" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "Name" = format("%s", var.name) }, var.tags)
}

resource "aws_route" "public_internet_gateway" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_egress_only_internet_gateway" "this" {
  count = var.enable_ipv6 ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "Name" = format("%s", var.name) }, var.tags)
}

resource "aws_route" "public_internet_gateway_ipv6" {
  count = var.enable_ipv6 && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id              = aws_route_table.public[0].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this[0].id
}
