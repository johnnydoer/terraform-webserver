# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Create a route table for public subnets
resource "aws_route_table" "rt_public" {
  count  = length(var.public_subnet_ids) # Number of public subnets
  vpc_id = var.vpc_id                    # ID of the VPC

  route {
    cidr_block = "0.0.0.0/0" # Route to the internet gateway for all traffic
    gateway_id = var.igw_id  # ID of the internet gateway
  }

  tags = {
    Name = "${var.route_table_prefix}-public-${count.index}" # Name tag for the public route table
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
# Associate public route table with public subnets
resource "aws_route_table_association" "rta_public" {
  count          = length(aws_route_table.rt_public)                     # Number of public route tables
  subnet_id      = element(var.public_subnet_ids, count.index)           # ID of the public subnet
  route_table_id = element(aws_route_table.rt_public[*].id, count.index) # ID of the public route table
}

# Create a route table for private subnets
resource "aws_route_table" "rt_private" {
  count  = length(var.private_subnet_ids) # Number of private subnets
  vpc_id = var.vpc_id                     # ID of the VPC

  route {
    cidr_block = "0.0.0.0/0"                         # Route to the NAT gateway for all traffic
    gateway_id = element(var.natgw_ids, count.index) # ID of the NAT gateway
  }

  tags = {
    Name = "${var.route_table_prefix}-private-${count.index}" # Name tag for the private route table
  }
}

# Associate private route table with private subnets
resource "aws_route_table_association" "rta_private" {
  count          = length(aws_route_table.rt_private)                     # Number of private route tables
  subnet_id      = element(var.private_subnet_ids, count.index)           # ID of the private subnet
  route_table_id = element(aws_route_table.rt_private[*].id, count.index) # ID of the private route table
}
