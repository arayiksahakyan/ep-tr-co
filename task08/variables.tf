variable "name_prefix" {
  description = "Prefix used to generate the required resource names."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group and regional resources are deployed."
  type        = string
}

variable "common_tags" {
  description = "Tags applied to all tagged resources in this task."
  type        = map(string)
}

variable "redis_capacity" {
  description = "Capacity tier for Azure Cache for Redis."
  type        = number
}

variable "redis_sku_name" {
  description = "SKU name for Azure Cache for Redis."
  type        = string
}

variable "redis_family" {
  description = "SKU family for Azure Cache for Redis."
  type        = string
}

variable "redis_port" {
  description = "SSL port used by applications to connect to Redis."
  type        = number
}

variable "redis_ssl_mode" {
  description = "Redis SSL mode value passed to the application."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Key Vault secret name that stores the Redis hostname."
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Key Vault secret name that stores the Redis primary access key."
  type        = string
}

variable "keyvault_sku_name" {
  description = "SKU name for Azure Key Vault."
  type        = string
}

variable "key_vault_secret_rotation_interval" {
  description = "AKS Key Vault CSI driver secret rotation interval."
  type        = string
}

variable "acr_sku" {
  description = "SKU for Azure Container Registry."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image repository name for the containerized application."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag built and deployed by the Terraform configuration."
  type        = string
}

variable "repository_url" {
  description = "Git repository URL used as the Azure Container Registry Task build context."
  type        = string
}

variable "repository_branch" {
  description = "Git branch used by the Azure Container Registry Task source context and trigger."
  type        = string
}

variable "docker_context_path" {
  description = "Path inside the repository that contains the Dockerfile and application source."
  type        = string
}

variable "git_pat" {
  description = "Personal access token used by Azure Container Registry Task to access the Git source context."
  type        = string
  sensitive   = true
}

variable "aci_sku" {
  description = "SKU for the Azure Container Instance container group."
  type        = string
}

variable "aci_container_cpu" {
  description = "CPU allocation for the Azure Container Instance application container."
  type        = number
}

variable "aci_container_memory" {
  description = "Memory allocation in GB for the Azure Container Instance application container."
  type        = number
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace where the application manifests are applied."
  type        = string
}

variable "aks_default_node_pool_name" {
  description = "Name of the AKS default node pool."
  type        = string
}

variable "aks_default_node_pool_node_count" {
  description = "Node count for the AKS default node pool."
  type        = number
}

variable "aks_default_node_pool_vm_size" {
  description = "Virtual machine size for the AKS default node pool nodes."
  type        = string
}

variable "aks_default_node_pool_os_disk_type" {
  description = "OS disk type for the AKS default node pool."
  type        = string
}

variable "aks_default_node_pool_os_disk_size_gb" {
  description = "OS disk size in GB for the AKS default node pool."
  type        = number
}
