# Kubernetes The Hard Way - AWS (Manual)
This tutorial walks you through setting up Kubernetes the hard way using Kelsey Hightower [Kubernetes The Hard Way (https://github.com/kelseyhightower/kubernetes-the-hard-way) on AWS.

## Cluster Details
Kubernetes The Hard Way guides you through bootstrapping a highly available Kubernetes cluster with end-to-end encryption between components and RBAC authentication.

* [Kubernetes](https://github.com/kubernetes/kubernetes) 1.24.3
* [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/) 1.27.3
* [Container Runtime - cri-o](https://github.com/cri-o/cri-o/blob/main/install.md#readme) 1.5.9
* [CNI Container Networking](https://github.com/containernetworking/cni) 0.9.1
* [Weave Networking (addon)](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)
* [etcd](https://github.com/coreos/etcd) v3.5.3
* [CoreDNS](https://github.com/coredns/coredns) v1.9.4

## Labs

This tutorial assumes you have access to the [AWS Cloud](https://aws.amazon.com/console/). (The original KTHW uses GCP)

* [Prerequisites](labs/01-prerequisites.md)
* [Installing the Client Tools](labs/02-client-tools.md)
* [Provisioning Compute Resources](labs/03-compute-resources.md)
* [Provisioning the CA and Generating TLS Certificates](labs/04-certificate-authority.md)
* [Generating Kubernetes Configuration Files for Authentication](labs/05-kubernetes-configuration-files.md)
* [Generating the Data Encryption Config and Key](labs/06-data-encryption-keys.md)
* [Bootstrapping the etcd Cluster](labs/07-bootstrapping-etcd.md)
* [Bootstrapping the Kubernetes Control Plane](labs/08-bootstrapping-kubernetes-controllers.md)
* [Bootstrapping the Kubernetes Worker Nodes](labs/09-bootstrapping-kubernetes-workers.md)
* [Configuring kubectl for Remote Access](labs/10-configuring-kubectl.md)
* [Provisioning Pod Network Routes](labs/11-pod-network-routes.md)
* [Deploying the DNS Cluster Add-on](labs/12-dns-addon.md)
* [Smoke Test](labs/13-smoke-test.md)
* [Cleaning Up](labs/14-cleanup.md)

## Kubernetes Documentation
* [Kubernetes Documentation Home](https://kubernetes.io/docs/home/)

## High Level Steps
Following are the high-level steps involved in setting up a kubeadm-based Kubernetes cluster.
1. Install container runtime on all nodes. (we will be using `containerd`)
2. Install `kubeadm`, `kubelet`, and `kubectl` on all the nodes.
3. Initiate `kubeadm` control plane configuration on the master node.
4. Save the node join command with the token
5. Install the Network Plugin (This is done using Routes in AWS Cloud)
6. Join the worker node to the master node (control plane) using the join command.
7. Validate all cluster components and nodes.
8. Install Kubernetes Metrics Server
9. Deploy a sample app and validate the app