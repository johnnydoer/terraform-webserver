variable "nat_gw_prefix" {
  description = "A prefix for NAT gateway names to facilitate unique identification"
  type        = string
  default     = "webserver-natgw"
}

variable "igw_id" {
  description = "Internet Gateway ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}