module "postgresql" {
  source = "./modules/postgresql"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  postgres_version    = var.postgres_version
  postgres_storage_mb = var.postgres_storage_mb
  postgres_sku        = var.postgres_sku
  delegated_subnet_id = module.virtual_network.postgres_subnet_id
  private_dns_zone_id = module.virtual_network.private_dns_zone_id
  key_vault_id        = module.security.key_vault_id
  tags                = var.tags


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

module "redis" {
  source = "./modules/redis"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  redis_capacity      = var.redis_capacity
  redis_family        = var.redis_family
  redis_sku_name      = var.redis_sku_name
  key_vault_id        = module.security.key_vault_id
  tags                = var.tags
}

moved {
  from = azurerm_redis_cache.main
  to   = module.redis.azurerm_redis_cache.main
}

moved {
  from = azurerm_key_vault_secret.redis_connection_string
  to   = module.redis.azurerm_key_vault_secret.redis_connection_string
}

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.main.primary_connection_string
  key_vault_id = module.security.key_vault_id
}
