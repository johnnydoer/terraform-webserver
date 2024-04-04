# Define an output value that will display the IDs of the NAT Gateways after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway#id
output "natgw_ids" {
  value = aws_nat_gateway.natgw[*].id # The IDs of the NAT Gateways are derived from the aws_nat_gateway resource created
}

# Define an output value that will display the IDs of the Elastic IP addresses associated with NAT Gateways after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip#id
output "nat_gw_eip_ids" {
  value = aws_eip.natgw_eip[*].id # The IDs of the Elastic IP addresses associated with NAT Gateways are derived from the aws_eip resource created
}
