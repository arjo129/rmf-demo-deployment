# RMF Demo Deployment

Tools for deploying a server to demonstrate RMF using wireguard for private communication via the public internet.

## Terraform project

The `terraform` directory contains scripts for using [terraform](https://terraform.io) to create a server in AWS capable of running an RMF demo.

See <./terraform/README.md> for more information.

## Chef cookbook

The `rmf_demo` directory contains a chef cookbook which can configure the server created by and several clients.

See <./rmf_demo/README.md> for more information.
