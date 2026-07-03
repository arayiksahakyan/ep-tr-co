output "id" {
  description = "ID of the Azure Container Instance container group."
  value       = azurerm_container_group.main.id
}

output "fqdn" {
  description = "FQDN of the Azure Container Instance container group."
  value       = azurerm_container_group.main.fqdn
}

output "ip_address" {
  description = "Public IP address of the Azure Container Instance container group."
  value       = azurerm_container_group.main.ip_address
}
