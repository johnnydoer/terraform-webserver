variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "ec2_name" {
  description = "Name of the Security Group"
  type        = string
  default     = "webserver-ec2-sg"
}

variable "alb_name" {
  description = "Name of the Security Group"
  type        = string
  default     = "webserver-alb-sg"
}