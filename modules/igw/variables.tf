# Variables from other modules
variable "vpc_id" {
  description = "The ID of the VPC where internet gateway will be created"
  type        = string
}

# Variables
variable "name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "webserver_igw"
}