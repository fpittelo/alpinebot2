output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}

output "openai_key_secret_id" {
  value = azurerm_key_vault_secret.openai_key.id
}

output "openai_id" {
  value = azurerm_cognitive_account.openai.id
}
