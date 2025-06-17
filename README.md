# Terraform AWS Environment

## 🔧 Overview

This repository defines an **infrastructure-as-code (IaC)** setup using Terraform to deploy a live AWS environment. The purpose of this environment is to demonstrate:

- Real-world infrastructure workflows
- Secure and scalable architecture
- Integration with CI/CD pipelines
- Security tooling and best practices

It is ideal for showcasing DevSecOps practices, infrastructure automation, and modular Terraform design.

---

## 🛠️ What’s Included

- ✅ **AWS Resources**
  - VPC, Subnets, Security Groups
  - EC2 Instances, S3 Buckets
  - CloudTrail for audit logging
  - IAM roles/policies
- ✅ **Terraform Cloud Integration**
  - Remote backend
  - VCS-triggered runs
  - Workspace management
- ✅ **Modular Design**
  - Separated Terraform files for scalability
  - Reusable variable blocks and outputs
- ✅ **Multi-provider Support (optional)**
  - Kubernetes integration (EKS-ready)
  - Aliased AWS accounts (dev/staging/prod)

---

## 🚀 Getting Started

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- AWS account with IAM credentials
- Terraform Cloud account and workspace

### Deployment Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/aws-terraform-live.git
   cd aws-terraform-live
