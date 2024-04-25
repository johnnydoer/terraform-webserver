# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# Create an Elastic IP (EIP) for each NAT Gateway
resource "aws_eip" "natgw_eip" {
  count  = length(var.public_subnet_ids) # Number of elastic IPs to create based on the length of the provided public subnets
  domain = "vpc"                         # Specify the domain of the EIP as "vpc"

  depends_on = [var.igw_id] # Ensure that the Internet Gateway is created before creating the EIP
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
# Create a NAT Gateway for each public subnet
resource "aws_nat_gateway" "natgw" {
  count         = length(var.public_subnet_ids)                 # Number of NAT Gateways to create based on the length of the provided public subnets
  subnet_id     = var.public_subnet_ids[count.index]            # ID of the current public subnet
  allocation_id = element(aws_eip.natgw_eip[*].id, count.index) # ID of the EIP associated with the NAT Gateway

  tags = {
    Name = "${var.nat_gw_prefix}-${count.index}" # Name tag for the NAT Gateway
  }

  depends_on = [aws_eip.natgw_eip] # Ensure that the Elastic IP (EIP) is created before creating the NAT Gateway
}
