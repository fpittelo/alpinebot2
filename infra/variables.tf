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
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    Project = "AlpineBot"
    ManagedBy = "Terraform"
  }
}
