module "postgresql" {
  source = "./modules/postgresql"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  postgres_version    = var.postgres_version
  postgres_storage_mb = var.postgres_storage_mb
  postgres_sku        = var.postgres_sku
  delegated_subnet_id = azurerm_subnet.postgres.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id
  key_vault_id        = module.security.key_vault_id
  tags                = var.tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres]
}

moved {
  from = random_password.postgres_password
  to   = module.postgresql.random_password.postgres_password
}

moved {
  from = azurerm_postgresql_flexible_server.main
  to   = module.postgresql.azurerm_postgresql_flexible_server.main
}

moved {
  from = azurerm_postgresql_flexible_server_database.main
  to   = module.postgresql.azurerm_postgresql_flexible_server_database.main
}

moved {
  from = azurerm_postgresql_flexible_server_configuration.extensions
  to   = module.postgresql.azurerm_postgresql_flexible_server_configuration.extensions
}

moved {
  from = azurerm_key_vault_secret.postgres_password
  to   = module.postgresql.azurerm_key_vault_secret.postgres_password
}

moved {
  from = azurerm_key_vault_secret.postgres_connection_string
  to   = module.postgresql.azurerm_key_vault_secret.postgres_connection_string
}

# Firewall rule removed as we are using VNet integration

resource "azurerm_redis_cache" "main" {
  name                = "${var.environment}-redis-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.redis_sku_name
  non_ssl_port_enabled = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = merge(var.tags, { Environment = var.environment })
}

# Store secrets in Key Vault
# Note: Postgres secrets moved to module

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.main.primary_connection_string
  key_vault_id = module.security.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.main.primary_connection_string
  key_vault_id = module.security.key_vault_id
}
