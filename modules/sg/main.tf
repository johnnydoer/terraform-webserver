# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# Create an AWS security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id # ID of the VPC to associate the security group with

  tags = {
    Name = var.ec2_name # Name tag for the security group
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# Define an ingress rule for the EC2 security group to allow all traffic from any source
resource "aws_vpc_security_group_ingress_rule" "ec2_sg_ingress" {
  security_group_id = aws_security_group.ec2_sg.id # ID of the EC2 security group to apply the rule to

  referenced_security_group_id = aws_security_group.alb_sg.id
  ip_protocol                  = "tcp" # Protocol to allow (all protocols)
  from_port                    = 80
  to_port                      = 80

}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
# Define an egress rule for the EC2 security group to allow all traffic to any destination
resource "aws_vpc_security_group_egress_rule" "ec2_sg_egress" {
  security_group_id = aws_security_group.ec2_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing to any destination)
  ip_protocol = "-1"        # Protocol to allow (all protocols)
}

# Create an AWS security group for Application Load Balancer instances
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id # ID of the VPC to associate the security group with

  tags = {
    Name = var.alb_name # Name tag for the security group
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# Define an ingress rule for the EC2 security group to allow all traffic from any source
resource "aws_vpc_security_group_ingress_rule" "alb_http_sg_ingress" {
  security_group_id = aws_security_group.alb_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing from any source)
  ip_protocol = "tcp"       # Protocol to allow (all protocols)
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "alb_https_sg_ingress" {
  security_group_id = aws_security_group.alb_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing from any source)
  ip_protocol = "tcp"       # Protocol to allow (all protocols)
  from_port   = 443
  to_port     = 443
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
# Define an egress rule for the EC2 security group to allow all traffic to any destination
resource "aws_vpc_security_group_egress_rule" "alb_sg_egress" {
  security_group_id = aws_security_group.alb_sg.id # ID of the EC2 security group to apply the rule to

  cidr_ipv4   = "0.0.0.0/0" # CIDR block for IPv4 addresses (allowing to any destination)
  ip_protocol = "-1"        # Protocol to allow (all protocols)
}