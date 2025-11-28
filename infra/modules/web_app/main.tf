resource "azurerm_linux_web_app" "frontend" {
  name                = "${var.environment}-app-${var.project_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      node_version = "22-lts"
    }
    app_command_line = "node /home/site/wwwroot/server.js"
  }

  app_settings = {
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1800"
  }

  tags = merge(var.tags, { Environment = var.environment })
}
