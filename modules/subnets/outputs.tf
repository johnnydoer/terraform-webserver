# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet#id
output "public_subnet_ids" {
  value = aws_subnet.public[*].id # The IDs of the public subnets are derived from the aws_subnet resource created for public subnets
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id # The IDs of the private subnets are derived from the aws_subnet resource created for private subnets
}
