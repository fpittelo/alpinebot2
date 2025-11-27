resource "azurerm_service_plan" "main" {
  name                = "${var.environment}-asp-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = merge(var.tags, { Environment = var.environment })
}

module "function_app" {
  source = "./modules/function_app"

  project_name         = var.project_name
  environment          = var.environment
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  service_plan_id      = azurerm_service_plan.main.id
  subnet_id            = azurerm_subnet.function.id
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
