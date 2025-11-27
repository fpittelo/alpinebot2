module "virtual_network" {
  source = "./modules/virtual_network"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

moved {
  from = azurerm_virtual_network.main
  to   = module.virtual_network.azurerm_virtual_network.main
}

moved {
  from = azurerm_subnet.postgres
  to   = module.virtual_network.azurerm_subnet.postgres
}

moved {
  from = azurerm_subnet.function
  to   = module.virtual_network.azurerm_subnet.function
}

moved {
  from = azurerm_private_dns_zone.postgres
  to   = module.virtual_network.azurerm_private_dns_zone.postgres
}

moved {
  from = azurerm_private_dns_zone_virtual_network_link.postgres
  to   = module.virtual_network.azurerm_private_dns_zone_virtual_network_link.postgres
}

moved {
  from = azurerm_network_watcher.main
  to   = module.virtual_network.azurerm_network_watcher.main
}
