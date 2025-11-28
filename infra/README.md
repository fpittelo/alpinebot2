# Infrastructure as Code (Terraform)

This directory contains the Terraform configuration for deploying the AlpineBot.ch infrastructure on Azure.

## Overview

The infrastructure is defined as a modular setup, managed via GitHub Actions. No local deployment is permitted.

### Key Resources

- **Resource Group**: Container for all resources (e.g., `dev-alpinebot-2`).
- **Networking**: VNet with subnets for App Service and Database (VNet Integration).
- **Database**: Azure Database for PostgreSQL (Flexible Server) with `pgvector`.
- **AI**: Azure OpenAI Service (GPT-4o).
- **Compute**:
  - Azure App Service (Linux) for Frontend.
  - Azure Functions (Linux Consumption) for Backend.
- **Security**: Key Vault for secret management (RBAC model).
- **Monitoring**: Application Insights & Log Analytics.

## State Management

Terraform state is stored remotely in an Azure Storage Account.

- **Resource Group**: `{env}-bkd-alpinebot-2`
- **Storage Account**: `{env}bkdalpinebot2`
- **Container**: `tfstate`
- **Key**: `terraform.tfstate`

This backend infrastructure is bootstrapped automatically by the `Deploy Backend (TF State)` stage in the CI/CD pipeline.

## Inputs

The primary input variable is `environment` (`dev`, `qa`, `main`), which drives naming conventions and resource sizing (if differentiated).

## Deployment

Deployment is handled exclusively by the `deploy.yaml` workflow in `.github/workflows/`.

```bash
# Example of how the pipeline runs init
terraform init \
  -backend-config="resource_group_name=..." \
  -backend-config="storage_account_name=..." \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform.tfstate"

# Example of how the pipeline runs plan/apply
terraform apply -var="environment=dev"
```
