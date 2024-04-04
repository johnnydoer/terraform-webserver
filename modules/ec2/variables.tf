variable "ubuntu_ami" {
  description = "AMI ID for Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2024-03-01, Architecture 64-bit (x86)"
  type        = string
  default     = "ami-08116b9957a259459"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "sg_id" {
  description = "The ID of the SG where subnets will be created"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

