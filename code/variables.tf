#################################
# Created By: pinaki ghosh      #
# Date: Aug 2023                #
#################################
variable "environment_name" {
    description = "Name of the AWS environment"
    #type = string
}

variable "aws_account" {
    description = "Value of the AWS Account"
    type = number
}

variable "region" {
    description = "AWS Region name where deployed"
    type = string
}

variable "aws_user" {
    description = "Name of AWS user"
    type = string
}

variable "ami" {
    description = "default AMI"
    default = "ami-08e5424edfe926b43"
}

variable "control_plane_node_ebs" {
    description = "Size of EBS disk"
    type = number
}

variable "worker_node_ebs" {
    description = "Size of EBS disk"
    type = number
}

variable "cidr_block" {
    description = "Network Range"
}

variable "availability_zone" {
  description = "Default availability Zones in the region"
  #type = string
}

variable "private_subnets" {
    description = "Default private subnet"
    #type = string
}

variable "public_subnets" {
    description = "Default public subnet"
    #type = string
}