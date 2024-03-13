# Define variables that can be passed to the Terraform configuration
variable "region" {
 description = "AWS region to deploy resources in"
 default     = "us-west-2"
}

variable "ami_id" {
 description = "AMI ID for the instances"
 default     = "ami-07d9b9ddc6cd8dd30"
}
