data "azurerm_client_config" "current" {}

module "security" {
  source = "./modules/security"

  project_name             = var.project_name
  environment              = var.environment
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  client_object_id         = data.azurerm_client_config.current.object_id
  key_vault_sku            = var.key_vault_sku
  purge_protection_enabled = var.purge_protection_enabled
  tags                     = var.tags
}

moved {
  from = azurerm_key_vault.main
  to   = module.security.azurerm_key_vault.main
}

moved {
  from = azurerm_key_vault_access_policy.client
  to   = module.security.azurerm_key_vault_access_policy.client
}

resource "azurerm_key_vault_access_policy" "function_app" {
  key_vault_id = module.security.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.function_app.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}
