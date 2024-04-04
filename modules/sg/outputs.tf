# Define an output value that will display the ID of the EC2 security group after the Terraform apply
# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#id
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id # The ID of the EC2 security group is derived from the aws_security_group resource created
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id # The ID of the EC2 security group is derived from the aws_security_group resource created
}