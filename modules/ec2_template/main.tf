resource "aws_launch_template" "ec2_template" {
  name                   = var.name
  image_id               = var.ubuntu_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.ec2_sg_id]
  user_data              = filebase64("./${path.module}/ec2.sh")
  key_name               = aws_key_pair.webserver_ec2_key.key_name
  monitoring {
    enabled = true
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_connect_endpoint
# Create an EC2 Instance Connect endpoint for accessing EC2 instances in a private subnet
resource "aws_ec2_instance_connect_endpoint" "ec2_private_connect" {
  subnet_id          = var.private_subnet_ids[0] # ID of the private subnet to associate the endpoint with
  security_group_ids = [var.ec2_sg_id]           # IDs of the security groups to associate with the endpoint
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# Create an AWS key pair for SSH access to EC2 instances
resource "aws_key_pair" "webserver_ec2_key" {
  key_name   = "webserver-ec2-key"                                                                                      # Name for the key pair
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtF/KnmapwHi4bzhS/zdxYH3yW3ONRTdQCcbZpuck6N ayush@DESKTOP-ERA88R8" # Public key value
}