# Define outputs that can be useful for debugging or further automation
output "vpc_id" {
  value = module.vpc.vpc_id # Output the VPC ID
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids # Output the public subnet IDs
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids # Output the private subnet IDs
}

output "igw_id" {
  value = module.igw.igw_id
}