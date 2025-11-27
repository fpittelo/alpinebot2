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

variable "openai_sku_name" {
  description = "The SKU name of the Azure OpenAI service."
  type        = string
  default     = "S0"
}

variable "openai_deployment_name" {
  description = "The name of the OpenAI deployment."
  type        = string
  default     = "gpt-4o"
}

variable "openai_model_name" {
  description = "The name of the OpenAI model to deploy."
  type        = string
  default     = "gpt-4o"
}

variable "openai_model_version" {
  description = "The version of the OpenAI model to deploy."
  type        = string
  default     = "2024-11-20"
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to store the API key."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
