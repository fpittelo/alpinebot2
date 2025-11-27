output "openai_endpoint" {
  value       = module.openai.openai_endpoint
  description = "The endpoint used to connect to the Azure OpenAI service."
}

output "openai_id" {
  value       = module.openai.openai_id
  description = "The ID of the Azure OpenAI service."
}
