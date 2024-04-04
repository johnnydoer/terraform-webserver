output "ec2_key" {
  value = aws_key_pair.webserver_ec2_key.key_name
}

output "ec2_public_id" {
  value = aws_instance.ec2_public.id
}

output "ec2_public_interface_id" {
  value = aws_network_interface.ec2_public_interface.id
}

output "ec2_public_IP" {
  value = aws_instance.ec2_public.public_ip
}