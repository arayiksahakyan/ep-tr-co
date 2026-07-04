resource "azurerm_kubernetes_cluster" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  oidc_issuer_enabled = true
  tags                = var.tags

  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.default_node_pool_node_count
    vm_size         = var.default_node_pool_vm_size
    os_disk_type    = var.default_node_pool_os_disk_type
    os_disk_size_gb = var.default_node_pool_os_disk_size_gb

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = var.key_vault_secret_rotation_interval
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

resource "azurerm_key_vault_access_policy" "aks_secret_provider" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get",
    "List",
  ]
}
