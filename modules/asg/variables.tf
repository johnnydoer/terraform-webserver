# Variables from other modules
variable "ec2_template_id" {
  type = string
}

variable "ec2_alb_id" {
  type = string
}

variable "ec2_alb_target_group" {
  type = any
}

# Variables
variable "name" {
  type    = string
  default = "webserver-asg"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}