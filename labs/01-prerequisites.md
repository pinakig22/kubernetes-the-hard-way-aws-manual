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

### Example Output
aws --version
aws-cli/2.13.12 Python/3.11.4 Darwin/22.6.0 exe/x86_64 prompt/off
```

### Configure AW CLI - Set a Default Compute Region and Zone
This tutorial assumes a default *compute region* and *zone* have been configured.
Refer to [Configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) in order to setup default region and zone.

Refer to [How to use command line options](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-options.html#cli-configure-options-how) to know more about using AWS CLI.
```bash
### To list all configuration data
aws configure list

### Example Output ###
aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************M5PO shared-credentials-file
secret_key     ****************Evby shared-credentials-file
    region               ap-south-1      config-file    ~/.aws/config

### List Configured profiles
aws configure list-profiles

### Example Output ###
$ aws configure list-profiles
aws-sso-prod-account
prod
iamadmin
default
$ 
```

Next: [Installing Client Tools](02-client-tools.md)