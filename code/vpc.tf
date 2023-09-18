#################################
# Created By: pinaki ghosh      #
# Date: Aug 2023                #
#################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment_name}-vpc"
  cidr = var.cidr_block

  azs = "${var.availability_zone}"
  private_subnets = "${var.private_subnets}"
  public_subnets = "${var.public_subnets}"

  tags = {
    Terraform = "true"
    Environment = "pg_prod"
  }
}