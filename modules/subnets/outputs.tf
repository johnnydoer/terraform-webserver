# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet#id
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
