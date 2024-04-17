output "ec2_alb_id" {
  value = aws_lb.ec2_alb.id # The EC2 instance ID is derived from the aws_instance resource created
}

output "ec2_alb_target_group" {
  value = aws_lb_target_group.ec2_alb_target_group
}

output "ec2_alb_dns" {
  value = aws_lb.ec2_alb.dns_name
}