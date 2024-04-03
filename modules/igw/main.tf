# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
# Create internet gateway for publlic subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}
