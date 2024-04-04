# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

# Docs: https://developer.hashicorp.com/terraform/language/meta-arguments/count#the-count-object
# Docs: https://developer.hashicorp.com/terraform/language/meta-arguments/count#count-index
# Docs: https://developer.hashicorp.com/terraform/language/functions/element
# Create public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)              # Number of public subnets to create
  vpc_id                  = var.vpc_id                                   # ID of the VPC in which to create the subnet
  cidr_block              = var.public_subnets_cidr[count.index]         # CIDR block for the current public subnet
  map_public_ip_on_launch = true                                         # Assign a public IP address to instances launched in this subnet
  availability_zone       = element(var.availability_zones, count.index) # Availability zone for the current public subnet

  tags = {
    Name = "${var.subnet_prefix}-public-${count.index}" # Name tag for the current public subnet
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)             # Number of private subnets to create
  vpc_id            = var.vpc_id                                   # ID of the VPC in which to create the subnet
  cidr_block        = var.private_subnets_cidr[count.index]        # CIDR block for the current private subnet
  availability_zone = element(var.availability_zones, count.index) # Availability zone for the current private subnet

  tags = {
    Name = "${var.subnet_prefix}-private-${count.index}" # Name tag for the current private subnet
  }
}
