# Variables from other modules
variable "alb_sg_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

# Variables
variable "name" {
  type    = string
  default = "webserver-alb"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
