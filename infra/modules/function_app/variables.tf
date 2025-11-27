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

variable "service_plan_id" {
  description = "The ID of the Service Plan."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the Function App."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "openai_endpoint" {
  description = "The endpoint of the OpenAI service."
  type        = string
}

variable "openai_key_secret_id" {
  description = "The ID of the Key Vault secret containing the OpenAI API key."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
