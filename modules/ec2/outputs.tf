# Define an output value that will display the EC2 key name after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair#key_name
output "ec2_key" {
  value = aws_key_pair.webserver_ec2_key.key_name # The EC2 key name is derived from the aws_key_pair resource created
}

# Define an output value that will display the EC2 instance ID after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#id
output "ec2_public_id" {
  value = aws_instance.ec2_public.id # The EC2 instance ID is derived from the aws_instance resource created
}

# Define an output value that will display the EC2 network interface ID after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface#id
output "ec2_public_interface_id" {
  value = aws_network_interface.ec2_public_interface.id # The EC2 network interface ID is derived from the aws_network_interface resource created
}

# Define an output value that will display the public IP address of the EC2 instance after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#public_ip
output "ec2_public_IP" {
  value = aws_instance.ec2_public.public_ip # The public IP address of the EC2 instance is derived from the aws_instance resource created
}
