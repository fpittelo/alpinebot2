output "key_vault_id" {
  value = azurerm_key_vault.main.id
  # Ensure access policy is applied before returning ID to prevent permission errors on secret creation
  depends_on = [azurerm_key_vault_access_policy.client]
}

output "key_vault_name" {
  value = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}
