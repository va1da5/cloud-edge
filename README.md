# Cloud Edge 🌤️

This repository contains tools to help you bootstrap virtual machines in AWS cloud. It is not a complete solution, but should put you on the right direction while taking initial steps. It is meant to extend your computer's hardware capabilities using public cloud resources.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [make (optional)](https://www.gnu.org/software/make/)

## Terraform

[Terraform configuration](./terraform/) is being used to provision resources in AWS.

**⚠️ Remember to destroy infrastructure once it is no longer needed ⚠️**

### Variables

- **INSTANCE_SIZE** (default: *s*) - Size of the instance using t-shirt size terminology. See [locals.tf](./terraform/locals.tf) for a list of available sizes and their corresponding cost.
- **ROOT_STORAGE_SIZE** (default: *10*) - Size of the root volume in GB
- **AMI_NAME** (default: *rhel8*) - Name of the Amazon Machine Images (AMI) to use. See [locals.tf](./terraform/locals.tf) for a list of available AMIs.
- **KEEP_DATA** (default: *false*) - Whether to keep the data on the instance after it is destroyed.
- **PUBLIC_KEY_PATH** (default: *~/.ssh/id_rsa.pub*) - Path to the public key to use for SSH access.
- **PRIVATE_KEY_PATH** (default: *~/.ssh/id_rsa*) - Path to the private key to use for SSH access using Ansible.

The variables could be set using `terraform.tfvars` file or exporting them to the environment. Please see the example below.

```bash
export TF_VAR_INSTANCE_SIZE=xl
export TF_VAR_ROOT_STORAGE_SIZE=20
```

Once it is ready, you can run `make deploy` to create resources. Also, it could be done manually.

```bash
cd terraform
terraform init
terraform apply
```

Later, you can access the virtual machine using SSH.

```bash
ssh ec2-user@<public-ip-of-the-machine>
```

### Usage of `aws.env`

Terraform configuration will create `aws.env` file with useful aliases and Docker configuration. The file could be loaded using `source ./aws.env` in the current shell. Later, `aws-connect` alias could be used to connect to the remote machine. Please see the examples below.

```bash
# load the file
source ./aws.env

# connect to the remote machine via SSH
aws-connect

# create a port forward from localhost:8000 to the remote machine on 127.0.0.1:8000
aws-tunnel 8000 127.0.0.1 8000

# list all tunnels
aws-tunnel-list

# stop specific tunnel
aws-tunnel-stop <pid>

# deactivate aws context
aws-deactivate
```

### Security

The default security group will only allow SSH access to your public IP address. You can add additional rules to the group to allow access to other machines in [security.tf](./terraform/security.tf) file.

## Ansible

Once the cloud components are in place, you can use [Ansible](https://www.ansible.com/) to provision the resources in the virtual machine. [Ansible playbook](./ansible/playbook.yml) should be reviewed and updated to match requirements.

```bash
make provision

# or 
cd ansible; \
  ansible-playbook -i inventory/aws playbook.yml
```

## Remote Docker

It is possible to perform development on a remote machine running Docker. Simply export `DOCKER_HOST` variable as per example below.

```bash
# using aws.env
source ./aws.env

# manually
export DOCKER_HOST=ssh://ec2-user@<public-ip-of-the-machine>
docker info
```

## Port Forwarding

As only SSH port is exposed, there could be some issues when trying to access other services or ports on a remote machine. However, before making holes and exposing services to the Internet, it is recommended to try using port-forwarding via SSH. Examples below.

```bash
# port forward traffic from localhost:8080 to remote machine 127.0.0.1:37597
# -fN - keeps the connection alive
ssh -fN -L 127.0.0.1:8080:127.0.0.1:37597 ec2-user@<public-ip-of-the-machine>

# the same could be achieved using aws.env
ssh -fN -L 8080:127.0.0.1:37597 $AWS_SSH_HOST

# list open tunnels
ps -ax | grep "ssh -fN" | grep -v grep

# kill the tunnel
kill -15 <pid> 
```

## References

- [AWS CLI Configuration basics](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- [Locating AWS Marketplace AMI Owner Id and Image Name for Packer Builds](https://blog.gruntwork.io/locating-aws-ami-owner-id-and-image-name-for-packer-builds-7616fe46b49a)
- [How to Run Remote Docker Commands using SSH](https://www.serverlab.ca/tutorials/containers/docker/how-to-access-remote-docker-daemon-using-ssh/)
- [Visual Studio Code Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
- [Mounting SSH connections so you can handle remote files as if they were local](https://towardsdatascience.com/mounting-an-ssh-connection-so-you-can-treat-its-files-as-if-they-were-local-8c3ed0acbb49)
- [Make an Amazon EBS volume available for use on Linux](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)

