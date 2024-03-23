# Declare a variable to hold the CIDR block for the VPC
variable "cidr_block" {
  description = "The CIDR block for the VPC"  # Description of the variable
  type        = string                        # The type of the variable, in this case, a string
  default     = "10.0.0.0/16"
}

# Declare a variable for naming the VPC, with a default value
variable "name" {
  description = "The name of the VPC"  # Description of the variable
  type        = string                 # The type of the variable, in this case, a string
  default     = "webserver_vpc"        # Default value for the variable if not explicitly provided
}
