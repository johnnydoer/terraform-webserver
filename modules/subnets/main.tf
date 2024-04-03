# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Create public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr) # Docs: https://developer.hashicorp.com/terraform/language/meta-arguments/count#the-count-object
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets_cidr[count.index] # Docs: https://developer.hashicorp.com/terraform/language/meta-arguments/count#count-index
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index) # Docs: https://developer.hashicorp.com/terraform/language/functions/element

  tags = {
    Name = "${var.subnet_prefix}-public-${count.index}"
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.subnet_prefix}-private-${count.index}"
  }
}
  