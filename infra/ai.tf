module "openai" {
  source = "./modules/openai"

  project_name           = var.project_name
  environment            = var.environment
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg.name
  openai_sku_name        = var.openai_sku_name
  openai_deployment_name = var.openai_deployment_name
  openai_model_name      = var.openai_model_name
  openai_model_version   = var.openai_model_version
  key_vault_id           = module.security.key_vault_id
  tags                   = var.tags
}

moved {
  from = azurerm_cognitive_account.openai
  to   = module.openai.azurerm_cognitive_account.openai
}

moved {
  from = azurerm_cognitive_deployment.gpt_4o
  to   = module.openai.azurerm_cognitive_deployment.gpt_4o
}

moved {
  from = azurerm_key_vault_secret.openai_key
  to   = module.openai.azurerm_key_vault_secret.openai_key
}
