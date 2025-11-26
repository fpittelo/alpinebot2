output "openai_endpoint" {
  value       = azurerm_cognitive_account.openai.endpoint
  description = "The endpoint used to connect to the Azure OpenAI service."
}

output "openai_id" {
  value       = azurerm_cognitive_account.openai.id
  description = "The ID of the Azure OpenAI service."
}
