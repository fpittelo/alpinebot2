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

variable "redis_capacity" {
  description = "The size of the Redis cache to deploy."
  type        = number
  default     = 0
}

variable "redis_family" {
  description = "The SKU family/pricing group to use."
  type        = string
  default     = "C"
}

variable "redis_sku_name" {
  description = "The SKU of Redis to use."
  type        = string
  default     = "Basic"
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
