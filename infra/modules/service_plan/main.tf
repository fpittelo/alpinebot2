resource "azurerm_service_plan" "main" {
  name                = "${var.environment}-asp-${var.project_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = merge(var.tags, { Environment = var.environment })
}
