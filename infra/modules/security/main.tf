resource "azurerm_key_vault" "main" {
  name                        = "${var.environment}-kv-${var.project_name}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = var.key_vault_sku

  rbac_authorization_enabled = false

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.client_object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]
}
