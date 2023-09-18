#################################
# Created By: pinaki ghosh      #
# Date: Aug 2023                #
#################################
environment_name = "pg_prod"
aws_account = "492337326462"
aws_user =  "iamadmin"
ami = "var.ami"
region = "ap-south-1"

cidr_block = "10.0.0.0/16"
availability_zone = ["ap-south-1c","ap-south-1b","ap-south-1c"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

control_plane_node_ebs = 16
worker_node_ebs = 8


