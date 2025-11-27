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

variable "log_retention_days" {
  description = "The retention period for the logs in days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
