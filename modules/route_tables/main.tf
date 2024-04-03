# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "rt-public" {
  count  = length(var.public_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.route_table_prefix}-public-${count.index}"
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "rta-public" {
  count          = length(aws_route_table.rt-public)
  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = element(aws_route_table.rt-public[*].id, count.index)
}

resource "aws_route_table" "rt-private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(var.natgw_ids, count.index)
  }

  tags = {
    Name = "${var.route_table_prefix}-private-${count.index}"
  }
}

resource "aws_route_table_association" "rta-private" {
  count          = length(aws_route_table.rt-private)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = element(aws_route_table.rt-private[*].id, count.index)
}

