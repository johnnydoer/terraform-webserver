resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_sg_ingress" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  # from_port   = 0
  ip_protocol = "-1"
  # to_port     = 0
}

resource "aws_vpc_security_group_egress_rule" "ec2_sg_egress" {
  security_group_id = aws_security_group.ec2_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  # from_port   = 0
  ip_protocol = "-1"
  # to_port     = 0
}