# Provisioning Resources
We will need to provision the following resources in AWS:

- **Networking**: VPC, Subnet, Internet Gateway (IGW), Route Tables, Security Groups, Load Balancer (ALB)
- **Compute Instances**: EC2 nodes for master and worker nodes, & SSH Key Pairs.

## Pre-requisites
- Have an AWS account setup. AWS provides Free Tier usage for 12 months for new accounts.
- Install AWS CLI for interacting with AWS Account from local machine. (Refer to installation [details](https://github.com/pinakig22/kubernetes-the-hard-way-aws/blob/main/labs/02-client-tools.md#aws-cli) in previous step).

## Compute Resources
Kubernetes requires a set of machines to host the Kubernetes **control plane** (**master** node) and the **worker nodes** where containers are ultimately run.

In this lab you will provision the compute resources required for running a secure and highly available Kubernetes cluster across a single [AWS Region with multiple Availability Zone](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).

## Networking
The Kubernetes [networking model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#kubernetes-model) assumes a flat network in which containers and nodes can communicate with each other.

In cases where this is not desired [network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) can limit how groups of containers are allowed to communicate with each other and external network endpoints.

> Setting up network policies is out of scope for this tutorial.

## Virtual Private Cloud
In this section a dedicated [AWS VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) will be setup to host the Kubernetes cluster.
We will be using Terraform to create the VPC which is recommended way to avoid manual errors.

> Default VPC is present in AWS which can also be used for simplicity.

To create AWS VPC refer to AWS Guide [Create a VPC](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html). Below are the configuration options used:

| **Configuration**                  | **Value**       |
|:-----------------------------------|:----------------|
| Availability Zones                 | `ap-south-1`    |
| IPv4 CIDR block                    | `10.0.0.0/16`   |
| IPv6 CIDR block                    | Skip            |
| DNS options                        | Enable both (Default) |
| Internet Gateway                   | NO              | 
| Name                               | kthw-vpc        |
| NAT gateways                       | Yes             |
| Tenancy                            | Default         |
| Number of Availability Zones (AZs) | 3               |
| Number of public & private subnets | 3 & 3           |
|choose the number of AZs in which to create NAT gateways| in each AZ|
