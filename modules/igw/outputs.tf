# Define an output value that will display the Internet Gateway ID after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway#id
output "igw_id" {
  value       = aws_internet_gateway.igw.id      # The Internet Gateway ID is derived from the aws_internet_gateway resource created
  description = "The ID of the Internet Gateway" # Description of the output
}
