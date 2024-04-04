# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# Create an AWS key pair for SSH access to EC2 instances
resource "aws_key_pair" "webserver_ec2_key" {
  key_name   = "webserver-ec2-key"                                                                                      # Name for the key pair
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtF/KnmapwHi4bzhS/zdxYH3yW3ONRTdQCcbZpuck6N ayush@DESKTOP-ERA88R8" # Public key value
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface
# Create a network interface for the EC2 instance to be launched in a public subnet
resource "aws_network_interface" "ec2_public_interface" {
  subnet_id       = var.public_subnet_ids[0] # ID of the public subnet
  security_groups = [var.sg_id]              # ID of the security group to associate with the network interface
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Create an EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami           = var.ubuntu_ami                          # ID of the AMI to use for the instance
  instance_type = var.instance_type                       # Type of EC2 instance to launch
  key_name      = aws_key_pair.webserver_ec2_key.key_name # Name of the key pair to use for SSH access

  network_interface {                                                    # Configuration for the network interface of the instance
    network_interface_id = aws_network_interface.ec2_public_interface.id # ID of the network interface to attach
    device_index         = 0                                             # Index of the device for the network interface
  }

  tags = {
    Name = "webserver-public-ubuntu" # Name tag for the EC2 instance
  }
}
