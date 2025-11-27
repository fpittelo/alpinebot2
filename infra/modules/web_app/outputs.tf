output "web_app_id" {
  value = azurerm_linux_web_app.frontend.id
}

output "web_app_name" {
  value = azurerm_linux_web_app.frontend.name
}

output "web_app_default_hostname" {
  value = azurerm_linux_web_app.frontend.default_hostname
}
