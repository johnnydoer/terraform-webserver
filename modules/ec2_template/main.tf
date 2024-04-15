# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
# Define a launch template for EC2 instances
resource "aws_launch_template" "ec2_template" {
  name                   = var.name                                # Name of the launch template
  image_id               = var.ubuntu_ami                          # ID of the AMI to use for the instance
  instance_type          = var.instance_type                       # Type of EC2 instance to launch
  vpc_security_group_ids = [var.ec2_sg_id]                         # IDs of the security groups to associate with the instance
  user_data              = filebase64("./${path.module}/ec2.sh")   # User data script for instance initialization
  key_name               = aws_key_pair.webserver_ec2_key.key_name # Name of the key pair to use for SSH access
  monitoring {
    enabled = true # Enable detailed monitoring for the instance
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_connect_endpoint
# Create an EC2 Instance Connect endpoint for accessing EC2 instances in a private subnet
# resource "aws_ec2_instance_connect_endpoint" "ec2_private_connect" {
#   subnet_id          = var.private_subnet_ids[0] # ID of the private subnet to associate the endpoint with
#   security_group_ids = [var.ec2_endpoint_sg_id]  # IDs of the security groups to associate with the endpoint
# }

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# Create an AWS key pair for SSH access to EC2 instances
resource "aws_key_pair" "webserver_ec2_key" {
  key_name   = "webserver-ec2-key"                                                                                      # Name for the key pair
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtF/KnmapwHi4bzhS/zdxYH3yW3ONRTdQCcbZpuck6N ayush@DESKTOP-ERA88R8" # Public key value
}
