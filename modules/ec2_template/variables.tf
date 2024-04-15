variable "name" {
  type    = string
  default = "webserver-ec2-template"
}

variable "ubuntu_ami" {
  description = "AMI ID for Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2024-03-01, Architecture 64-bit (x86)"
  type        = string
  default     = "ami-08116b9957a259459"
  # default = "ami-0395649fbe870727e"
}

variable "alb_sg_id" {
  description = "The ID of the SG where subnets will be created"
  type        = string
}

variable "ec2_sg_id" {
  description = "The ID of the SG where subnets will be created"
  type        = string
}

variable "ec2_endpoint_sg_id" {
  description = "The ID of the SG where subnets will be created"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "private_subnet_ids" {
  type = list(string)

}