locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : length(var.private_subnets)
}

resource "aws_eip" "nat" {
  #bridgecrew:skip=BC_AWS_NETWORKING_48:False positive. This EIP is attached to a NAT gateway instead of an EC2 instance.
  count = var.enable_nat_gateway ? local.nat_gateway_count : 0

  domain = "vpc"
  tags   = merge({ "Name" = format("%s-%s", var.name, element(var.azs, var.single_nat_gateway ? 0 : count.index)) }, var.tags)
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? local.nat_gateway_count : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, var.single_nat_gateway ? 0 : count.index)
  tags          = merge({ "Name" = format("%s-%s", var.name, element(var.azs, var.single_nat_gateway ? 0 : count.index)) }, var.tags)
  depends_on    = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_ipv6_egress" {
  count = var.enable_ipv6 ? (var.single_nat_gateway ? 1 : length(var.private_subnets)) : 0

  route_table_id              = element(aws_route_table.private.*.id, count.index)
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = element(aws_egress_only_internet_gateway.this.*.id, 0)
}
