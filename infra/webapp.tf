resource "azurerm_linux_web_app" "frontend" {
  name                = "${var.environment}-app-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      node_version = "22-lts"
    }
    app_command_line = "node /home/site/wwwroot/server.js"
  }

  app_settings = {
    "WEBSITES_PORT" = "3000"
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1800"
  }

  tags = merge(var.tags, { Environment = var.environment })
}
