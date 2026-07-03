variable "name" {
  description = "Name of the Azure Container Instance container group."
  type        = string
}

variable "location" {
  description = "Azure region where the container group is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the container group."
  type        = string
}

variable "sku" {
  description = "SKU for the Azure Container Instance container group."
  type        = string
}

variable "dns_name_label" {
  description = "DNS name label used to expose the Azure Container Instance container group."
  type        = string
}

variable "image" {
  description = "Container image reference deployed to Azure Container Instance."
  type        = string
}

variable "container_name" {
  description = "Name of the application container inside the container group."
  type        = string
}

variable "container_cpu" {
  description = "CPU allocation for the application container."
  type        = number
}

variable "container_memory" {
  description = "Memory allocation in GB for the application container."
  type        = number
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
}

variable "acr_login_server" {
  description = "Login server of the Azure Container Registry."
  type        = string
}

variable "acr_admin_username" {
  description = "Admin username used by Azure Container Instance to pull from Azure Container Registry."
  type        = string
}

variable "acr_admin_password" {
  description = "Admin password used by Azure Container Instance to pull from Azure Container Registry."
  type        = string
  sensitive   = true
}

variable "redis_port" {
  description = "SSL Redis port exposed to the application."
  type        = number
}

variable "redis_ssl_mode" {
  description = "Redis SSL mode exposed to the application."
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname read from Key Vault and passed as a secure environment variable."
  type        = string
}

variable "redis_primary_access_key" {
  description = "Redis primary access key read from Key Vault and passed as a secure environment variable."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to the Azure Container Instance container group."
  type        = map(string)
}
