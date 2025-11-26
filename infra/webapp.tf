resource "azurerm_linux_web_app" "frontend" {
  name                = "${var.environment}-app-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      node_version = "24-lts"
    }
    app_command_line = "npx serve -s dist"
  }

  app_settings = {
    "WEBSITES_PORT" = "3000"
  }

  tags = merge(var.tags, { Environment = var.environment })
}
