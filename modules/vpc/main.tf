# Create a resource of type "aws_vpc" named "main"
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block  # Set the CIDR block for the VPC, referencing the cidr_block variable
  enable_dns_support   = true            # Enable DNS support within the VPC (helpful for resolving AWS service endpoints)
  enable_dns_hostnames = true            # Enable DNS hostnames within the VPC (allows EC2 instances to receive DNS hostnames)
  instance_tenancy     = "default"       # Set instance tenancy to "default", meaning instances can be on shared or dedicated hardware

  # Define tags for the VPC, including a "Name" tag, utilizing the name variable
  tags = {
    Name = var.name
  }
}
