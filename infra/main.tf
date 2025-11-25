resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-${var.project_name}"
  location = var.location
  tags     = merge(var.tags, { Environment = var.environment })
}
