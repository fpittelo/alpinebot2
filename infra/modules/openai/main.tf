resource "azurerm_cognitive_account" "openai" {
  name                = "${var.environment}-openai-${var.project_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
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

resource "azurerm_key_vault_secret" "openai_key" {
  name         = "openai-api-key"
  value        = azurerm_cognitive_account.openai.primary_access_key
  key_vault_id = var.key_vault_id
}
