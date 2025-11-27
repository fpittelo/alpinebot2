resource "azurerm_redis_cache" "main" {
  name                = "${var.environment}-redis-${var.project_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.redis_sku_name
  non_ssl_port_enabled = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.main.primary_connection_string
  key_vault_id = var.key_vault_id
}
