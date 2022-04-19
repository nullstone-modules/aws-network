resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id                          = aws_vpc.this[0].id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = element(var.azs, count.index)
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = false

  tags = merge({ "Name" = format("%s-private-%s", var.name, element(var.azs, count.index)) }, var.tags)
}

resource "aws_route_table" "private" {
  count = var.single_nat_gateway ? 1 : length(var.private_subnets)

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "Name" = var.single_nat_gateway ? "${var.name}-private" : format("%s-private-%s", var.name, element(var.azs, count.index)) }, var.tags)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, var.single_nat_gateway ? 0 : count.index)
}
