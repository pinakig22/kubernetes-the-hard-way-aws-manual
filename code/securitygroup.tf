#################################
# Created By: pinaki ghosh      #
# Date: Aug 2023                #
#################################
module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name = "ssh-sg"
  description = "SSH access"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "control_plane_node_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = "control-plane-sg"
  description = "Control Plane Node Security Group"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port = 6443
      to_port = 6443
      protocol = "tcp"
      description = "Kubernetes API server"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port = 2379
      to_port = 2380
      protocol = "tcp"
      description = "kube-apiserver, etcd access"
      cidr_block = "0.0.0.0/0"
    },
    {
      from_port = 10250
      to_port = 10250
      protocol = "tcp"
      description = "Self"
      cidr_block = "0.0.0.0/0"
    }
  ]

}