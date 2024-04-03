# Use modules to create the VPC, subnets, security groups, NAT gateways, and load balancer
module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id # Use the VPC ID from the VPC module
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id # Use the VPC ID from the VPC module
}

module "natgw" {
  source            = "./modules/natgw"
  public_subnet_ids = module.subnets.public_subnet_ids
  igw_id            = module.igw.igw_id
}