resource "azurerm_cognitive_account" "openai" {
  name                = "${var.environment}-openai-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = var.openai_sku_name

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_cognitive_deployment" "gpt_4o" {
  name                 = var.openai_deployment_name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = var.openai_model_name
    version = var.openai_model_version
  }

  sku {
    name     = "Standard"
    capacity = 10 # Tokens per minute limit (thousands), adjust as needed
  }
}

resource "azurerm_role_assignment" "function_openai" {
  scope                = azurerm_cognitive_account.openai.id
  role_definition_name = "Cognitive Services User"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}
