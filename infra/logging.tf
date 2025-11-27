module "logging" {
  source = "./modules/logging"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  log_retention_days  = var.log_retention_days
  tags                = var.tags
}

moved {
  from = azurerm_log_analytics_workspace.main
  to   = module.logging.azurerm_log_analytics_workspace.main
}

moved {
  from = azurerm_application_insights.main
  to   = module.logging.azurerm_application_insights.main
}
