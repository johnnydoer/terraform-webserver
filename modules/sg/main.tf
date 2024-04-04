# Create an AWS security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id # ID of the VPC to associate the security group with

  tags = {
    Name = var.name # Name tag for the security group
  }
}

# Define an ingress rule for the EC2 security group to allow all traffic from any source
resource "aws_vpc_security_group_ingress_rule" "ec2_sg_ingress" {
  security_group_id = aws_security_group.ec2_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing from any source)
  ip_protocol = "-1"        # Protocol to allow (all protocols)
}

# Define an egress rule for the EC2 security group to allow all traffic to any destination
resource "aws_vpc_security_group_egress_rule" "ec2_sg_egress" {
  security_group_id = aws_security_group.ec2_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing to any destination)
  ip_protocol = "-1"        # Protocol to allow (all protocols)
}
