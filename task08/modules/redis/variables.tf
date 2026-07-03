variable "name" {
  description = "Name of the Azure Cache for Redis instance."
  type        = string
}

variable "location" {
  description = "Azure region where the Azure Cache for Redis instance is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the Azure Cache for Redis instance."
  type        = string
}

variable "capacity" {
  description = "Capacity tier for Azure Cache for Redis."
  type        = number
}

variable "family" {
  description = "SKU family for Azure Cache for Redis."
  type        = string
}

variable "sku_name" {
  description = "SKU name for Azure Cache for Redis."
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Azure Key Vault where Redis connection secrets are stored."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the Key Vault secret that stores the Redis hostname."
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Name of the Key Vault secret that stores the Redis primary access key."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Azure Cache for Redis instance."
  type        = map(string)
}
