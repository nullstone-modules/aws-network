resource "aws_subnet" "intra" {
  count = length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0

  vpc_id                          = aws_vpc.this[0].id
  cidr_block                      = var.intra_subnets[count.index]
  availability_zone               = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  assign_ipv6_address_on_creation = false
  tags                            = merge({ "Name" = format("%s-intra-%s", var.name, element(var.azs, count.index)) }, var.tags)
}

resource "aws_route_table" "intra" {
  count = length(var.intra_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "Name" = "${var.name}-intra" }, var.tags)
}

resource "aws_route_table_association" "intra" {
  count = length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0

  subnet_id      = element(aws_subnet.intra.*.id, count.index)
  route_table_id = element(aws_route_table.intra.*.id, 0)
}
