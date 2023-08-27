# Prerequisites
## AWS Cloud Platform

This tutorial leverages the AWS Cloud Platform to streamline provisioning of the compute infrastructure required to bootstrap a Kubernetes cluster from the ground up.

> The compute resources required for this tutorial may exceed the AWS Cloud Platform free tier.

## AWS Cloud Platform SDK
### Install the AWS CLI

Follow the AWS [documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions) to install and configure **`awscli`** command line utility.

Verify the AWS CLI version 2.x.x or higher using `aws --version`:

```bash
~ aws --version
~ tbc
```

### Configure AW CLI - Set a Default Compute Region and Zone
This tutorial assumes a default *compute region* and *zone* have been configured.

```bash
## Set default compute region
TBC

## Set default compute zone
TBC
```

Next: [Installing Client Tools](02-client-tools.md)