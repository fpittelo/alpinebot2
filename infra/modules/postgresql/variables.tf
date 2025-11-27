variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev, qa, main)"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "postgres_version" {
  description = "The version of PostgreSQL to use."
  type        = string
  default     = "16"
}

variable "postgres_storage_mb" {
  description = "The storage capacity of the PostgreSQL server in megabytes."
  type        = number
  default     = 32768
}

variable "postgres_sku" {
  description = "The SKU name for the PostgreSQL server."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "delegated_subnet_id" {
  description = "The ID of the subnet delegated to PostgreSQL."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone for PostgreSQL."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to store secrets."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
