# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway#id
output "natgw_ids" {
  value = aws_nat_gateway.natgw[*].id
}

output "nat_gw_eip_ids" {
  value = aws_eip.natgw_eip[*].id
}