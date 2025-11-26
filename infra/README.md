# Infrastructure

This directory contains the Terraform configuration for deploying the Azure infrastructure.

## Network Security

The infrastructure uses a **Virtual Network (VNet)** to secure the database.

- **PostgreSQL Flexible Server**: Deployed with VNet integration in a delegated subnet (`postgres-subnet`). Public access is **disabled**.
- **Private DNS Zone**: Used for internal name resolution of the database.
