resource "aws_launch_template" "ec2_template" {
  name                   = var.name
  image_id               = var.ubuntu_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.ec2_sg_id]

  monitoring {
    enabled = true
  }
}
