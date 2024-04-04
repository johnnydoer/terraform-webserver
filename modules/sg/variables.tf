variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "name" {
  description = "Name of the Security Group"
  type        = string
  default     = "webserver-ec2-sg"
}