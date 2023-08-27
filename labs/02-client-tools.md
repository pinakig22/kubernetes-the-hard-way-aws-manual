# Installing the Client Tools
In this lab you will install the command line utilities required to complete this tutorial: [cfssl](https://github.com/cloudflare/cfssl), [cfssljson](https://github.com/cloudflare/cfssl), and [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

`CFSSL` will be used to **set up our Public Key Infrastructure (PKI)**, while `kubectl` is the tool we will use to control the K8 cluster.

## `cfssl`
Kubernetes `master` and `worker` components **need to establish trust** before they can communicate.

This is achieved by distributing certificates to each component **signed by** the **same** *certificate authority (CA)*.

`CFSSL` is a CLI tool which can act as a **standalone CA**, generating the root CA certificate and executing certificate signing requests to produce additional certificates signed by that *CA*.

### Install `cfssl`
#### **On MAC (M1)**

Some OS X users may experience problems using the pre-built binaries in which case [Homebrew](https://brew.sh) might be a better option:

```
brew install cfssl
```

#### **Linux**

```bash
## install cfssl ##

VERSION=$(curl --silent "https://api.github.com/repos/cloudflare/cfssl/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
VNUMBER=${VERSION#"v"}
wget https://github.com/cloudflare/cfssl/releases/download/${VERSION}/cfssl_${VNUMBER}_linux_amd64 -O cfssl
chmod +x cfssl
sudo mv cfssl /usr/local/bin

### verify ###
➜  ~ cfssl version
Version: 1.6.4
Runtime: go1.20.3
➜  ~
➜  ~ cfssljson --version
Version: 1.6.4
Runtime: go1.20.3
➜  ~
```

## `kubectl`
**CLI control tool** of Kubernetes, which will be used for starting pods, creating deployments and services, and checking the cluster state.

The `kubectl` command line utility is **used to interact** with the Kubernetes API Server.

Kubectl’s **configuration** lives in `~/.kube/config`.

This file is loaded by `kubectl` on every executed command, so any changes will always take effect immediately.

The **config file** contains several contexts which then hold all the information needed to connect to a cluster. If you are working with different clusters or several users for the same cluster you can create a context for each of these. Switch between contexts using `kubectl config use-context <somecontext>`.

[Exhaustive list](https://kubernetes.io/docs/user-guide/kubectl-cheatsheet/) of useful kubectl commands

### Install `kubectl`

#### **On MAC (M1)**
Refer to [Install and Set Up kubectl on macOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/) to setup `kubectl` on MI MACs.

```bash
### Download ###
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"

### Make the kubectl binary executable ###
chmod +x ./kubectl

### Move the kubectl binary to a file location on your system PATH ###
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown root: /usr/local/bin/kubectl

### Verify version ###
kubectl version --client or kubectl version --short

### Example ###
➜  ~ kubectl version --client
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.3", GitCommit:"25b4e43193bcda6c7328a6d147b1fb73a33f1598", GitTreeState:"clean", BuildDate:"2023-06-14T09:53:42Z", GoVersion:"go1.20.5", Compiler:"gc", Platform:"darwin/arm64"}
Kustomize Version: v5.0.1
➜  ~ 

➜  ~ kubectl version --short
Flag --short has been deprecated, and will be removed in the future. The --short output will become the default.
Client Version: v1.27.3
Kustomize Version: v5.0.1
The connection to the server localhost:8080 was refused - did you specify the right host or port?
➜  ~
```
> Note: Make sure `/usr/local/bin` is in your `PATH` environment variable using `echo $PATH|grep "/usr/local/bin"` command.

#### **On Windows**
Refer to [Install and Set Up kubectl on Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/) to setup `kubelet` on Windows.

#### **On Linux**
Refer to [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) to setup `kubelet` on Linux.

## AWS CLI
The AWS Command Line Interface (AWS CLI) is an open source tool that enables you to interact with AWS services using commands in your command-line shell.

### Install AWS CLI on MAC (M1)
Refer to [AWS CLI install and update instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to install AWS CLI on MAC.

To verify that the shell can find and run the aws command in your `$PATH`, use the following commands.
```bash
which aws
aws --version

## Example ##
➜  ~ which aws
/usr/local/bin/aws
➜  ~ aws --version
aws-cli/2.13.12 Python/3.11.4 Darwin/22.5.0 exe/x86_64 prompt/off
➜  ~
```
### Configure AWS CLI
#### Setup Environment Variables
Environment variables provide another way to specify configuration options and credentials, and can be useful for scripting or temporarily setting a named profile as the default.

Next: [Provisioning Compute Resources](03-compute-resources.md)
