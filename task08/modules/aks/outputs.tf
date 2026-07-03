output "id" {
  description = "ID of the Azure Kubernetes Service cluster."
  value       = azurerm_kubernetes_cluster.main.id
}

output "name" {
  description = "Name of the Azure Kubernetes Service cluster."
  value       = azurerm_kubernetes_cluster.main.name
}

output "kube_config" {
  description = "Kubernetes client configuration used by the kubectl and kubernetes providers."
  value = {
    host                   = azurerm_kubernetes_cluster.main.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.main.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  }
  sensitive = true
}

output "key_vault_secrets_provider_client_id" {
  description = "Client ID of the AKS Key Vault Secrets Provider managed identity."
  value       = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "key_vault_secrets_provider_object_id" {
  description = "Object ID of the AKS Key Vault Secrets Provider managed identity."
  value       = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id
}
