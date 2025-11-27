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

variable "tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
}

variable "client_object_id" {
  description = "The Object ID of the client (user/SPN) running Terraform"
  type        = string
}

variable "key_vault_sku" {
  description = "The SKU name of the Key Vault."
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Whether to enable purge protection for the Key Vault."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
