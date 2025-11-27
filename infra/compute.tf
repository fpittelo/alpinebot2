module "service_plan" {
  source = "./modules/service_plan"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

moved {
  from = azurerm_service_plan.main
  to   = module.service_plan.azurerm_service_plan.main
}

module "function_app" {
  source = "./modules/function_app"

  project_name         = var.project_name
  environment          = var.environment
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  service_plan_id      = module.service_plan.service_plan_id
  subnet_id            = module.virtual_network.function_subnet_id
  key_vault_name       = module.security.key_vault_name
  openai_endpoint      = module.openai.openai_endpoint
  openai_key_secret_id = module.openai.openai_key_secret_id
  tags                 = var.tags
}

moved {
  from = azurerm_storage_account.func
  to   = module.function_app.azurerm_storage_account.func
}

moved {
  from = azurerm_linux_function_app.main
  to   = module.function_app.azurerm_linux_function_app.main
}
