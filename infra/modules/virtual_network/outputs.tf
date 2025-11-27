output "virtual_network_id" {
  value = azurerm_virtual_network.main.id
}

output "postgres_subnet_id" {
  value = azurerm_subnet.postgres.id
}

output "function_subnet_id" {
  value = azurerm_subnet.function.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.postgres.id
}
