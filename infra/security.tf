data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                        = "${var.environment}-kv-${var.project_name}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = var.key_vault_sku

  enable_rbac_authorization = true

  tags = merge(var.tags, { Environment = var.environment })
}
