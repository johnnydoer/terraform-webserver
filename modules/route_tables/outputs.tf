output "rt_public_ids" {
  value = aws_route_table.rt_public[*].id
}

output "rt_private_ids" {
  value = aws_route_table.rt_private[*].id
}
