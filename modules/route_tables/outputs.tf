# Define an output value that will display the IDs of the public route tables after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#id
output "rt_public_ids" {
  value = aws_route_table.rt_public[*].id # The IDs of the public route tables are derived from the aws_route_table resource created
}

# Define an output value that will display the IDs of the private route tables after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#id
output "rt_private_ids" {
  value = aws_route_table.rt_private[*].id # The IDs of the private route tables are derived from the aws_route_table resource created
}
