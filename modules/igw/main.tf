# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
# Create an Internet Gateway for the VPC to enable communication with the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id # ID of the VPC to attach the Internet Gateway to

  tags = {
    Name = var.name # Name tag for the Internet Gateway
  }
}
