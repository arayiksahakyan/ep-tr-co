output "id" {
  description = "ID of the Azure Cache for Redis instance."
  value       = azurerm_redis_cache.main.id
}

output "hostname" {
  description = "Hostname of the Azure Cache for Redis instance."
  value       = azurerm_redis_cache.main.hostname
}

output "ssl_port" {
  description = "SSL port of the Azure Cache for Redis instance."
  value       = azurerm_redis_cache.main.ssl_port
}

output "hostname_secret_id" {
  description = "ID of the Key Vault secret that stores the Redis hostname."
  value       = azurerm_key_vault_secret.redis_hostname.id
}

output "primary_key_secret_id" {
  description = "ID of the Key Vault secret that stores the Redis primary access key."
  value       = azurerm_key_vault_secret.redis_primary_key.id
}
