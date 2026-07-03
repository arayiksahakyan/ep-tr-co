variable "name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
}

variable "location" {
  description = "Azure region where the Azure Kubernetes Service cluster is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the Azure Kubernetes Service cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix used by the Azure Kubernetes Service cluster."
  type        = string
}

variable "default_node_pool_name" {
  description = "Name of the AKS default node pool."
  type        = string
}

variable "default_node_pool_node_count" {
  description = "Node count for the AKS default node pool."
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "Virtual machine size for the AKS default node pool."
  type        = string
}

variable "default_node_pool_os_disk_type" {
  description = "OS disk type for the AKS default node pool."
  type        = string
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS disk size in GB for the AKS default node pool."
  type        = number
}

variable "acr_id" {
  description = "ID of the Azure Container Registry that AKS is allowed to pull images from."
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Azure Key Vault that AKS is allowed to read secrets from."
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID used for Key Vault access policies."
  type        = string
}

variable "key_vault_secret_rotation_interval" {
  description = "AKS Key Vault CSI driver secret rotation interval."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Azure Kubernetes Service cluster."
  type        = map(string)
}
