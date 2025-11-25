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

variable "postgres_version" {
  description = "The version of PostgreSQL to use."
  type        = string
  default     = "16"
}

variable "postgres_storage_mb" {
  description = "The storage capacity of the PostgreSQL server in MB."
  type        = number
  default     = 32768
}

variable "postgres_sku" {
  description = "The SKU name of the PostgreSQL server."
  type        = string
  default     = "B_Standard_B1ms"
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

variable "openai_sku_name" {
  description = "The SKU name of the Azure OpenAI service."
  type        = string
  default     = "S0"
}

variable "openai_model_name" {
  description = "The name of the OpenAI model to deploy."
  type        = string
  default     = "gpt-4o"
}

variable "openai_model_version" {
  description = "The version of the OpenAI model to deploy."
  type        = string
  default     = "2024-05-13"
}

variable "openai_deployment_name" {
  description = "The name of the OpenAI deployment."
  type        = string
  default     = "gpt-4o"
}
