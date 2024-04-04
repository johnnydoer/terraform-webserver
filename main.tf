# Use a module to create the VPC
module "vpc" {
  source = "./modules/vpc" # Path to the VPC module
}

# Use a module to create the subnets
module "subnets" {
  source = "./modules/subnets" # Path to the subnets module
  vpc_id = module.vpc.vpc_id   # Use the VPC ID from the VPC module
}

# Use a module to create the internet gateway
module "igw" {
  source = "./modules/igw"   # Path to the internet gateway module
  vpc_id = module.vpc.vpc_id # Use the VPC ID from the VPC module
}

# Use a module to create the NAT gateways
module "natgw" {
  source            = "./modules/natgw"                # Path to the NAT gateways module
  public_subnet_ids = module.subnets.public_subnet_ids # Use the public subnet IDs from the subnets module
  igw_id            = module.igw.igw_id                # Use the Internet Gateway ID from the igw module
}

# Use a module to create route tables
module "route_tables" {
  source             = "./modules/route_tables"          # Path to the route tables module
  vpc_id             = module.vpc.vpc_id                 # Use the VPC ID from the VPC module
  igw_id             = module.igw.igw_id                 # Use the Internet Gateway ID from the igw module
  natgw_ids          = module.natgw.natgw_ids            # Use the NAT Gateway IDs from the natgw module
  private_subnet_ids = module.subnets.private_subnet_ids # Use the private subnet IDs from the subnets module
  public_subnet_ids  = module.subnets.public_subnet_ids  # Use the public subnet IDs from the subnets module
}

# Use a module to create security groups
module "sg" {
  source = "./modules/sg"    # Path to the security groups module
  vpc_id = module.vpc.vpc_id # Use the VPC ID from the VPC module
}

# Use a module to create EC2 instances
module "ec2" {
  source             = "./modules/ec2"                   # Path to the EC2 instances module
  ec2_sg_id              = module.sg.ec2_sg_id                   # Use the security group ID from the sg module
  private_subnet_ids = module.subnets.private_subnet_ids # Use the private subnet IDs from the subnets module
  public_subnet_ids  = module.subnets.public_subnet_ids  # Use the public subnet IDs from the subnets module
}
