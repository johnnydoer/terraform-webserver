# Define outputs that can be useful for debugging or further automation

# Output the VPC ID
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Output the public subnet IDs
output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

# Output the private subnet IDs
output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

# Output the Internet Gateway ID
output "igw_id" {
  value = module.igw.igw_id
}

output "certificate_arn" {
  value = module.certificates.certificate_arn
}

# # Output the public IP address of an EC2 instance
# output "ec2_public_IP" {
#   value = module.ec2.ec2_public_IP
# }
