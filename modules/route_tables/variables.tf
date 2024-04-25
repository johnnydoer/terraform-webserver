# Variables from other modules
variable "vpc_id" {
  description = "The ID of the VPC where route table will be created"
  type        = string
}

variable "igw_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "natgw_ids" {
  description = "The IDs of the Internet Gateway"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# Variables
variable "route_table_prefix" {
  description = "A prefix for subnet names to facilitate unique identification"
  type        = string
  default     = "webserver-rt"
}

