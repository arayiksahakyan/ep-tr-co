data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = var.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"

  name                   = local.keyvault_name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  sku_name               = var.keyvault_sku_name
  tenant_id              = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
  tags                   = var.common_tags
}

module "redis" {
  source = "./modules/redis"

  name                          = local.redis_name
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  capacity                      = var.redis_capacity
  family                        = var.redis_family
  sku_name                      = var.redis_sku_name
  key_vault_id                  = module.keyvault.id
  redis_hostname_secret_name    = var.redis_hostname_secret_name
  redis_primary_key_secret_name = var.redis_primary_key_secret_name
  tags                          = var.common_tags

  depends_on = [module.keyvault]
}

module "acr" {
  source = "./modules/acr"

  name                = local.acr_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.acr_sku
  task_name           = local.acr_task_name
  image_name          = local.app_image_name
  repository_url      = var.repository_url
  repository_branch   = var.repository_branch
  docker_context_path = var.docker_context_path
  git_pat             = var.git_pat
  tags                = var.common_tags
}

module "aks" {
  source = "./modules/aks"

  name                               = local.aks_name
  location                           = azurerm_resource_group.main.location
  resource_group_name                = azurerm_resource_group.main.name
  dns_prefix                         = local.aks_name
  default_node_pool_name             = var.aks_default_node_pool_name
  default_node_pool_node_count       = var.aks_default_node_pool_node_count
  default_node_pool_vm_size          = var.aks_default_node_pool_vm_size
  default_node_pool_os_disk_type     = var.aks_default_node_pool_os_disk_type
  default_node_pool_os_disk_size_gb  = var.aks_default_node_pool_os_disk_size_gb
  acr_id                             = module.acr.id
  key_vault_id                       = module.keyvault.id
  tenant_id                          = data.azurerm_client_config.current.tenant_id
  key_vault_secret_rotation_interval = var.key_vault_secret_rotation_interval
  tags                               = var.common_tags
}

data "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  key_vault_id = module.keyvault.id

  depends_on = [module.redis]
}

data "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key_secret_name
  key_vault_id = module.keyvault.id

  depends_on = [module.redis]
}

module "aci" {
  source = "./modules/aci"

  name                     = local.aci_name
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  sku                      = var.aci_sku
  dns_name_label           = local.aci_dns_name_label
  image                    = "${module.acr.login_server}/${local.app_image_name}"
  container_name           = local.container_name
  container_cpu            = var.aci_container_cpu
  container_memory         = var.aci_container_memory
  container_port           = var.container_port
  acr_login_server         = module.acr.login_server
  acr_admin_username       = module.acr.admin_username
  acr_admin_password       = module.acr.admin_password
  redis_port               = var.redis_port
  redis_ssl_mode           = var.redis_ssl_mode
  redis_hostname           = data.azurerm_key_vault_secret.redis_hostname.value
  redis_primary_access_key = data.azurerm_key_vault_secret.redis_primary_key.value
  tags                     = var.common_tags

  depends_on = [module.acr, module.redis]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    namespace                            = var.kubernetes_namespace
    secret_provider_class_name           = local.secret_provider_class_name
    kubernetes_secret_name               = local.kubernetes_secret_name
    redis_hostname_secret_name           = var.redis_hostname_secret_name
    redis_primary_key_secret_name        = var.redis_primary_key_secret_name
    key_vault_secrets_provider_client_id = module.aks.key_vault_secrets_provider_client_id
    key_vault_name                       = module.keyvault.name
    tenant_id                            = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    namespace                     = var.kubernetes_namespace
    app_name                      = var.docker_image_name
    container_name                = local.container_name
    image                         = "${module.acr.login_server}/${local.app_image_name}"
    container_port                = var.container_port
    redis_port                    = var.redis_port
    redis_ssl_mode                = var.redis_ssl_mode
    redis_hostname_secret_name    = var.redis_hostname_secret_name
    redis_primary_key_secret_name = var.redis_primary_key_secret_name
    secret_provider_class_name    = local.secret_provider_class_name
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body = templatefile("${path.module}/k8s-manifests/service.yaml", {
    namespace      = var.kubernetes_namespace
    app_name       = var.docker_image_name
    container_port = var.container_port
  })

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubectl_manifest" "app_service" {
  api_version = "v1"
  kind        = "Service"
  name        = var.docker_image_name
  namespace   = var.kubernetes_namespace

  depends_on = [kubectl_manifest.service]
}
