# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "natgw_eip" {
  count  = length(var.public_subnet_ids)
  domain = "vpc"

  depends_on = [var.igw_id]
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "natgw" {
  count         = length(var.public_subnet_ids)
  subnet_id     = var.public_subnet_ids[count.index]
  allocation_id = element(aws_eip.natgw_eip[*].id, count.index)

  tags = {
    Name = "${var.nat_gw_prefix}-${count.index}"
  }

  depends_on = [aws_eip.natgw_eip]
}

