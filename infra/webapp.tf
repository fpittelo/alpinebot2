module "web_app" {
  source = "./modules/web_app"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = module.service_plan.service_plan_id
  tags                = var.tags
}

moved {
  from = azurerm_linux_web_app.frontend
  to   = module.web_app.azurerm_linux_web_app.frontend
}
