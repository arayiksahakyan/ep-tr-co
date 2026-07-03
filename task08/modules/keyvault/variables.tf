variable "name" {
  description = "Name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region where the Azure Key Vault is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the Azure Key Vault."
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Azure Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID for the Azure Key Vault."
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user that receives full secret access to the Azure Key Vault."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Azure Key Vault."
  type        = map(string)
}
