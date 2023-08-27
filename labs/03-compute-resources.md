# Provisioning Resources
## Table of Contents
- [Pre-requisites](#pre-requisites)
- [Networking](#networking)
  - [VPC](#virtual-private-cloud)
  - [Subnets](#subnets)
  - [Security Groups](#security-groups)
- [Compute Instances](#ec2-compute-resources)
- [Connect to instance](#connect-to-ec2-instance)


We will need to provision the following resources in AWS:
- **Networking**: VPC, Subnet, Internet Gateway (IGW), Route Tables, Security Groups, Load Balancer (ALB)
- **Compute Instances**: EC2 nodes for master and worker nodes, & SSH Key Pairs.

## Pre-requisites
- Have an AWS account setup. AWS provides Free Tier usage for 12 months for new accounts.
- Install AWS CLI for interacting with AWS Account from local machine. (Refer to installation [details](https://github.com/pinakig22/kubernetes-the-hard-way-aws/blob/main/labs/02-client-tools.md#aws-cli) in previous step).

## Networking
The Kubernetes [networking model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#kubernetes-model) assumes a flat network in which containers and nodes can communicate with each other.

In cases where this is not desired [network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) can limit how groups of containers are allowed to communicate with each other and external network endpoints.

> Setting up network policies is out of scope for this tutorial.

## Virtual Private Cloud
In this section a dedicated [AWS VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) will be setup to host the Kubernetes cluster.
We will be using Terraform to create the VPC which is recommended way to avoid manual errors.

> Default VPC is present in AWS which can also be used for simplicity.

To create AWS VPC via console refer to AWS Guide [Create a VPC](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html). Below are the configuration options used:

| **Configuration**                                        | **Value**             |
|:---------------------------------------------------------|:----------------------|
| Availability Zones                                       | `ap-south-1`          |
| IPv4 CIDR block                                          | `10.0.0.0/24`         |
| IPv6 CIDR block                                          | Skip                  |
| DNS options                                              | Enable both (Default) |
| Internet Gateway                                         | NO                    | 
| Name                                                     | kthw-vpc              |
| NAT gateways                                             | Yes                   |
| Tenancy                                                  | Default               |
| Number of Availability Zones (AZs)                       | 3                     |
| Number of public & private subnets                       | 1 public & 3 private  |
| Choose the number of AZs in which to create NAT gateways | 1                     |

#### To create via AWS CLI
```bash
## Create VPC ##

VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/24 --output text --query 'Vpc.VpcId')
aws ec2 create-tags --resources ${VPC_ID} --tags Key=Name,Value=kthw-vpc
aws ec2 modify-vpc-attribute --vpc-id ${VPC_ID} --enable-dns-support '{"Value": true}'
aws ec2 modify-vpc-attribute --vpc-id ${VPC_ID} --enable-dns-hostnames '{"Value": true}'
```
## Subnets

```bash
## Create Private Subnet
## By using this CIDR range 10.0.1.0/24 we have up to 251 hosts (AWS uses first 4 and last 1 IP)

SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id ${VPC_ID} \
  --cidr-block 10.0.1.0/24 \
  --output text --query 'Subnet.SubnetId')

aws ec2 create-tags --resources ${SUBNET_ID} --tags Key=Name,Value=kthw-private-subnet
```

```bash
## Create NAT Gateway
## To enable instances in a private subnet to connect to the internet, you can create a NAT gateway

##### TBC #####
```

## Security Groups
Security Groups are needed to allow traffic between our instances, as well as access from client software. 
We define rules for communication between the controllers (master node/control plane) and workers; SSH, Kubernetes API server, HTTPS and ICMP (for pings)

```bash
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name kubernetes-from-scratch \
  --description "Kubernetes the hard way SG" \
  --vpc-id ${VPC_ID} \
  --output text --query 'GroupId')

aws ec2 create-tags --resources ${SECURITY_GROUP_ID} --tags Key=Name,Value=kthw-sg

aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol all --cidr 10.0.0.0/24
aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol all --cidr 10.200.0.0/16
aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 6443 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 443 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol icmp --port -1 --cidr 0.0.0.0/0
```

## Application Load Balancer
TBC

## EC2 (Compute Resources)
Kubernetes requires a set of machines to host the Kubernetes **control plane** (**master** node) and the **worker nodes** where containers are ultimately run.

In this lab you will provision the compute resources required for running a secure and highly available Kubernetes cluster across a multiple [Availability Zone with a AWS Region](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html). We are using `ap-south-1` for the demo.

The compute instances in this lab will be provisioned using [Ubuntu Server](https://ubuntu.com/server) 20.04, which has good support for the [`containerd` container](https://github.com/containerd/containerd) runtime.

Each EC2 instance will be provisioned with a **fixed** _private IP_ address to simplify the Kubernetes bootstrapping process.

### Kubernetes Controllers
We will create three EC2 instances which will host the Kubernetes control plane.

### Kubernetes Workers
Each worker instance requires a pod subnet allocation from the Kubernetes cluster CIDR range. The pod subnet allocation will be used to configure container networking in a later exercise. The pod-cidr instance metadata will be used to expose pod subnet allocations to compute instances at runtime.

> The Kubernetes cluster CIDR range is defined by the Controller Manager's (`kube-controller-manager`) `--cluster-cidr` flag. In this tutorial the cluster CIDR range will be set to 10.200.0.0/16. This will be used for POD IP Addressing.

## Connect to EC2 Instance

