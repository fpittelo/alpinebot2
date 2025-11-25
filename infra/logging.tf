resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.environment}-log-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_application_insights" "main" {
  name                = "${var.environment}-appi-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  tags                = merge(var.tags, { Environment = var.environment })
}
