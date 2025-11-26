resource "azurerm_storage_account" "func" {
  name                     = "${var.environment}stfunc${replace(var.project_name, "-", "")}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_service_plan" "main" {
  name                = "${var.environment}-asp-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_linux_function_app" "main" {
  name                = "${var.environment}-func-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.func.name
  storage_account_access_key = azurerm_storage_account.func.primary_access_key
  service_plan_id            = azurerm_service_plan.main.id

  site_config {
    application_stack {
      python_version = "3.11"
    }
    vnet_route_all_enabled = true
  }

  virtual_network_subnet_id = azurerm_subnet.function.id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "BUILD_FLAGS"                    = "UseExpressBuild"
    "ENABLE_ORYX_BUILD"              = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "PYTHON_ENABLE_WORKER_EXTENSIONS" = "1"
  }

  tags = merge(var.tags, { Environment = var.environment })
}
