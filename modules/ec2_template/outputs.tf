output "ec2_template_id" {
  value = aws_launch_template.ec2_template.id # The EC2 instance ID is derived from the aws_instance resource created
}