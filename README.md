# Terraform Learning Repository

This repository contains Terraform configurations for learning and experimenting with AWS infrastructure. The repository is organized into multiple feature branches, each demonstrating different Terraform concepts and deployment patterns.

## 📋 Table of Contents

- [Overview](#overview)
- [Branches](#branches)
  - [main](#main)
  - [feature/eks](#featureeks)
  - [feature/modules](#featuremodules)
  - [feature/provisioners](#featureprovisioners)
  - [feature/deploy-to-ec2-default](#featuredeploy-to-ec2-default)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Usage](#usage)

## Overview

This repository demonstrates various Terraform patterns for deploying AWS infrastructure, including:
- Basic VPC and EC2 deployments
- Modular Terraform architecture
- Terraform provisioners
- EKS (Elastic Kubernetes Service) cluster setup
- Infrastructure as Code best practices

## Branches

### main

**Purpose**: Base branch with foundational AWS infrastructure setup

**Description**: 
This branch contains the core infrastructure configuration that serves as the foundation for other feature branches. It includes:
- VPC (Virtual Private Cloud) setup with custom CIDR blocks
- Subnet configuration with availability zones
- Internet Gateway and Route Tables
- Security Groups for network access control
- EC2 instance deployment
- Nginx Docker container deployment via user_data scripts

**Key Files**:
- `main.tf` - Main Terraform configuration with all resources
- `entry-script.sh` - Shell script for server initialization

**Use Case**: Start here to understand basic Terraform resource definitions and AWS infrastructure components.

---

### feature/eks

**Purpose**: EKS (Elastic Kubernetes Service) cluster deployment using Terraform modules

**Description**:
This branch demonstrates deploying a Kubernetes cluster on AWS using official Terraform modules. It showcases:
- Using community-maintained Terraform modules (`terraform-aws-modules`)
- VPC module configuration with Kubernetes-specific tags
- EKS cluster setup with self-managed node groups
- Integration between VPC and EKS modules

**Key Files**:
- `vpc.tf` - VPC module configuration with Kubernetes tags
- `eks-cluster.tf` - EKS cluster module with node group configuration
- `terraform.tfvars` - Variable definitions for region and CIDR blocks

**Key Features**:
- Uses `terraform-aws-modules/vpc/aws` module (v6.6.0)
- Uses `terraform-aws-modules/eks/aws` module (v21.15.1)
- Kubernetes version: 1.35
- Self-managed node groups with t3.micro instances
- VPC configured with public and private subnets for Kubernetes workloads

**Use Case**: Learn how to deploy production-ready Kubernetes clusters using Terraform modules.

---

### feature/modules

**Purpose**: Demonstrates modular Terraform architecture with reusable modules

**Description**:
This branch refactors the monolithic `main.tf` into a modular structure, showing best practices for organizing Terraform code:
- Separation of concerns with dedicated modules
- Reusable subnet module
- Reusable webserver module
- Proper variable and output management

**Key Files**:
- `main.tf` - Root module that calls child modules
- `variables.tf` - Root-level variable definitions
- `outputs.tf` - Root-level outputs
- `modules/subnet/` - Subnet module with its own main.tf, variables.tf, outputs.tf
- `modules/webserver/` - Webserver module with its own main.tf, variables.tf, outputs.tf

**Key Features**:
- Modular architecture for better code organization
- Reusable components
- Clear separation between infrastructure components
- Demonstrates module composition

**Use Case**: Learn how to structure Terraform code for maintainability and reusability.

---

### feature/provisioners

**Purpose**: Demonstrates Terraform provisioners for post-deployment configuration

**Description**:
This branch shows how to use Terraform provisioners to configure resources after creation. It includes examples of:
- File provisioner - copying files to remote instances
- Remote-exec provisioner - executing scripts on remote instances
- Local-exec provisioner - executing commands on the local machine
- SSH connection configuration

**Key Features**:
- File transfer to EC2 instances
- Remote script execution
- Local command execution (e.g., saving IP addresses to files)
- SSH connection setup with private keys

**Note**: The code includes comments noting that provisioners are not recommended when alternatives like `user_data` are available. This branch is for educational purposes to understand provisioner capabilities.

**Use Case**: Learn about Terraform provisioners and when (or when not) to use them.

---

### feature/deploy-to-ec2-default

**Purpose**: EC2 deployment using user_data instead of provisioners

**Description**:
This branch demonstrates the recommended approach for EC2 instance configuration using `user_data` scripts instead of provisioners. It shows:
- EC2 instance deployment with user_data
- Using `user_data_replace_on_change` for proper lifecycle management
- Deployment of Nginx Docker containers via initialization scripts

**Key Features**:
- Uses `user_data` attribute (recommended over provisioners)
- `user_data_replace_on_change = true` for proper updates
- Cleaner approach to instance initialization
- Follows AWS and Terraform best practices

**Use Case**: Learn the recommended way to configure EC2 instances during deployment.

---

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed (version 1.0+)
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions
- SSH key pair for EC2 access (for branches that deploy EC2 instances)

### Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd terraform
   ```

2. **Checkout the branch you want to explore**:
   ```bash
   git checkout <branch-name>
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Review and customize variables**:
   - Create or modify `terraform.tfvars` with your values
   - Example variables needed:
     - `vpc_cidr_block`
     - `subnet_cidr_block`
     - `avail_zone`
     - `env_prefix`
     - `my_ip`
     - `instance_type`
     - `public_key_location`

5. **Plan your deployment**:
   ```bash
   terraform plan
   ```

6. **Apply the configuration**:
   ```bash
   terraform apply
   ```

7. **Destroy resources when done**:
   ```bash
   terraform destroy
   ```

## Branch Comparison

| Branch | Focus | Complexity | Use Case |
|--------|-------|------------|----------|
| `main` | Basic infrastructure | Low | Learning fundamentals |
| `feature/modules` | Code organization | Medium | Learning modular design |
| `feature/provisioners` | Post-deployment config | Medium | Understanding provisioners |
| `feature/deploy-to-ec2-default` | Best practices | Low-Medium | Production-ready EC2 setup |
| `feature/eks` | Kubernetes on AWS | High | Container orchestration |

## Notes

- Each branch is independent and can be explored separately
- Some branches build upon concepts from `main`
- Always review `terraform.tfvars` and adjust variables for your environment
- Remember to destroy resources after learning to avoid AWS charges
- The `feature/eks` branch requires additional AWS permissions for EKS cluster creation

## Contributing

This is a learning repository. Feel free to:
- Create new branches for additional learning experiments
- Improve documentation
- Add more examples

## License

This repository is for educational purposes.

