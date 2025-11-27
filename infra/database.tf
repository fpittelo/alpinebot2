resource "random_password" "postgres_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "${var.environment}-psql-${var.project_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = "psqladmin"
  administrator_password = random_password.postgres_password.result
  storage_mb             = var.postgres_storage_mb
  sku_name               = var.postgres_sku
  zone                   = "1"

  delegated_subnet_id           = azurerm_subnet.postgres.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id
  public_network_access_enabled = false

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres]

  tags = merge(var.tags, { Environment = var.environment })
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = "alpinebot_db"
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# Enable pgvector extension
resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.main.id
  value     = "vector"
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
resource "azurerm_key_vault_secret" "postgres_password" {
  name         = "postgres-admin-password"
  value        = random_password.postgres_password.result
  key_vault_id = module.security.key_vault_id
}

resource "azurerm_key_vault_secret" "postgres_connection_string" {
  name         = "postgres-connection-string"
  value        = "host=${azurerm_postgresql_flexible_server.main.fqdn} port=5432 dbname=${azurerm_postgresql_flexible_server_database.main.name} user=${azurerm_postgresql_flexible_server.main.administrator_login} password=${random_password.postgres_password.result} sslmode=require"
  key_vault_id = module.security.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.main.primary_connection_string
  key_vault_id = module.security.key_vault_id
}
