output "id" {
  description = "ID of the Azure Key Vault."
  value       = azurerm_key_vault.main.id
}

output "name" {
  description = "Name of the Azure Key Vault."
  value       = azurerm_key_vault.main.name
}

output "vault_uri" {
  description = "URI of the Azure Key Vault."
  value       = azurerm_key_vault.main.vault_uri
}

output "current_user_access_policy_id" {
  description = "ID of the current user Key Vault secrets access policy."
  value       = azurerm_key_vault_access_policy.current_user_secrets.id
}
