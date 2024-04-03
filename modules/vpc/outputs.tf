# Define an output value that will display the VPC ID after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#id
output "vpc_id" {
  value       = aws_vpc.main.id     # The VPC ID is derived from the aws_vpc resource created
  description = "The ID of the VPC" # Description of the output
}
