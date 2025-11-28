resource "azurerm_storage_account" "func" {
  name                     = "${var.environment}stfunc${replace(var.project_name, "-", "")}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_linux_function_app" "main" {
  name                = "${var.environment}-func-${var.project_name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.func.name
  storage_account_access_key = azurerm_storage_account.func.primary_access_key
  service_plan_id            = var.service_plan_id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "BUILD_FLAGS"                     = "UseExpressBuild"
    "ENABLE_ORYX_BUILD"               = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"  = "true"
    "PYTHON_ENABLE_WORKER_EXTENSIONS" = "1"
    "KEY_VAULT_NAME"                  = var.key_vault_name
    "AZURE_OPENAI_ENDPOINT"           = var.openai_endpoint
    "AZURE_OPENAI_API_KEY"            = "@Microsoft.KeyVault(SecretUri=${var.openai_key_secret_id})"
    "AZURE_OPENAI_DEPLOYMENT_NAME"    = "gpt-4o"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
    vnet_route_all_enabled = true
    cors {
      allowed_origins = ["https://${var.environment}-app-${var.project_name}.azurewebsites.net", "http://localhost:5173"]
      support_credentials = true
    }
  }

  tags = merge(var.tags, { Environment = var.environment })
}
