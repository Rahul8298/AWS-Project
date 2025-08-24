######################################################## Global Variables ##############################################################
variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name to be used for tagging"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

############################################################### AWS VPC ##############################################################
variable "cidr_block" {
  description = "Specify the CIDR Block for AWS VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "Mention the CIDR Blocks for Subnets"
  type        = list(string)
}

############################################################### AWS ECS ##############################################################

variable "container_image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}