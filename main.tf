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
  igw_id            = module.igw.igw_id                # Use the Internet Gateway ID from the igw module
  public_subnet_ids = module.subnets.public_subnet_ids # Use the public subnet IDs from the subnets module
}

# Use a module to create route tables
module "route_tables" {
  source             = "./modules/route_tables"          # Path to the route tables module
  vpc_id             = module.vpc.vpc_id                 # Use the VPC ID from the VPC module
  igw_id             = module.igw.igw_id                 # Use the Internet Gateway ID from the igw module
  natgw_ids          = module.natgw.natgw_ids            # Use the NAT Gateway IDs from the natgw module
  public_subnet_ids  = module.subnets.public_subnet_ids  # Use the public subnet IDs from the subnets module
  private_subnet_ids = module.subnets.private_subnet_ids # Use the private subnet IDs from the subnets module
}

# Use a module to create security groups
module "sg" {
  source = "./modules/sg"    # Path to the security groups module
  vpc_id = module.vpc.vpc_id # Use the VPC ID from the VPC module
}

# # Use a module to create EC2 instances
# module "ec2" {
#   source             = "./modules/ec2"                   # Path to the EC2 instances module
#   ec2_sg_id          = module.sg.ec2_sg_id               # Use the security group ID from the sg module
#   private_subnet_ids = module.subnets.private_subnet_ids # Use the private subnet IDs from the subnets module
#   public_subnet_ids  = module.subnets.public_subnet_ids  # Use the public subnet IDs from the subnets module
# }

# Use a module to create EC2 instances from templates
module "ec2_template" {
  source             = "./modules/ec2_template"          # Path to the EC2 instances module
  alb_sg_id          = module.sg.alb_sg_id               # Use the ALB security group ID from the sg module
  ec2_sg_id          = module.sg.ec2_sg_id               # Use the EC2 security group ID from the sg module
  ec2_endpoint_sg_id = module.sg.ec2_endpoint_sg_id      # Use the EC2 Endpoint security group ID from the sg module
  private_subnet_ids = module.subnets.private_subnet_ids # Use the private subnet IDs from the subnets module
}

# Use a module to create application load balancer
module "alb" {
  source            = "./modules/alb"                  # Path to the application load balancer module
  vpc_id            = module.vpc.vpc_id                # Use the VPC ID from the VPC module
  alb_sg_id         = module.sg.alb_sg_id              # Use the security group ID for the ALB from the sg module
  public_subnet_ids = module.subnets.public_subnet_ids # Use the public subnet IDs from the subnets module
  certificate_arn   = module.certificates.certificate_arn
}

# Use a module to create auto scaling group
module "asg" {
  source               = "./modules/asg"                     # Path to the auto scaling group module
  ec2_alb_id           = module.alb.ec2_alb_id               # Use the ALB ID from the alb module
  ec2_alb_target_group = module.alb.ec2_alb_target_group     # Use the target group from the alb module
  private_subnet_ids   = module.subnets.private_subnet_ids   # Use the private subnet IDs from the subnets module
  ec2_template_id      = module.ec2_template.ec2_template_id # Use the EC2 template ID from the ec2_template module
}

module "certificates" {
  source = "./modules/certificates" # Path to the auto scaling group module
}

module "cloudfront" {
  source             = "./modules/cloudfront" # Path to the auto scaling group module
  ec2_alb_id         = module.alb.ec2_alb_id
  ec2_alb_dns        = module.alb.ec2_alb_dns
  cf_certificate_arn = module.certificates.cf_certificate_arn
}

module "web_acl" {
  source = "./modules/web_acl" # Path to the auto scaling group module
}

