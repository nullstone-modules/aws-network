resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                          = aws_vpc.this[0].id
  cidr_block                      = var.public_subnets[count.index]
  availability_zone               = element(var.azs, count.index)
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = false
  map_customer_owned_ip_on_launch = false

  tags = merge({ "Name" = format("%s-public-%s", var.name, element(var.azs, count.index)) }, var.tags)
}

resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "Name" = format("%s-public", var.name) }, var.tags)
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}
