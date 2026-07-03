name_prefix = "cmtr-2gvu1fsw-mod8"
location    = "West Europe"

common_tags = {
  Creator = "arayik_sahakyan@epam.com"
}

redis_capacity                = 2
redis_sku_name                = "Basic"
redis_family                  = "C"
redis_port                    = 6380
redis_ssl_mode                = "True"
redis_hostname_secret_name    = "redis-hostname"
redis_primary_key_secret_name = "redis-primary-key"

keyvault_sku_name                     = "standard"
key_vault_secret_rotation_interval    = "2m"
acr_sku                               = "Basic"
docker_image_name                     = "cmtr-2gvu1fsw-mod8-app"
image_tag                             = "latest"
repository_url                        = "https://github.com/arayiksahakyan/ep-tr-co"
repository_branch                     = "main"
docker_context_path                   = "task08/application"
aci_sku                               = "Standard"
aci_container_cpu                     = 0.5
aci_container_memory                  = 1.5
container_port                        = 8080
kubernetes_namespace                  = "default"
aks_default_node_pool_name            = "system"
aks_default_node_pool_node_count      = 1
aks_default_node_pool_vm_size         = "Standard_D2ads_v6"
aks_default_node_pool_os_disk_type    = "Ephemeral"
aks_default_node_pool_os_disk_size_gb = 30
