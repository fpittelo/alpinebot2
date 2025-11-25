variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "alpinebot-2"
}

variable "environment" {
  description = "The deployment environment (dev, qa, main)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "main"], var.environment)
    error_message = "Environment must be one of: dev, qa, main."
  }
}

variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
  default     = "Switzerland North"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "The retention period for the logs in days."
  type        = number
  default     = 30
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
