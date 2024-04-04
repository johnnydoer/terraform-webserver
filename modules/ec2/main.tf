# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "webserver_ec2_key" {
  key_name   = "webserver-ec2-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtF/KnmapwHi4bzhS/zdxYH3yW3ONRTdQCcbZpuck6N ayush@DESKTOP-ERA88R8"
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface
resource "aws_network_interface" "ec2_public_interface" {
  subnet_id       = var.public_subnet_ids[0]
  security_groups = [var.sg_id]
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "ec2_public" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.webserver_ec2_key.key_name

  network_interface { # Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#network-and-credit-specification-example
    network_interface_id = aws_network_interface.ec2_public_interface.id
    device_index         = 0
  }

  tags = {
    Name = "webserver-public-ubuntu"
  }
}