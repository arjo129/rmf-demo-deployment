# RMF demo wireguard server

This directory contains a terraform project which creates a server in an isolated VPC in AWS.

## Requirements

[Terraform](https://terraform.io) version 0.14.

AWS account credentials configured locally.
To set them up you could use the [AWS CLI](https://aws.amazon.com/cli/).

## Creating infrastructure

Once you have terraform and your AWS credentials configured you can create the server using the `terraform apply` command.
Pick an AWS region near you when prompted.

Terraform keeps track of your created infrastructure.
By default it does so with "tfstate" files.
These files are not committed to the repository and so if you lose the local repository your created infrastructure will not be updatable or destroyable by terraform.

## Destroying infrastructure

When finished with a demo deployment or things are so fouled up you want to start over run `terraform destroy` and enter the same region again.
