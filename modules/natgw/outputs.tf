# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway#id
output "natgw_ids" {
  value = aws_nat_gateway.natgw[*].id
}