# Variables from other modules
variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

# Variables
variable "public_subnets_cidr" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones in which to create subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "subnet_prefix" {
  description = "A prefix for subnet names to facilitate unique identification"
  type        = string
  default     = "webserver-sub"
}
