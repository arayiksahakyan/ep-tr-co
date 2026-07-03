variable "name" {
  description = "Name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the Azure Container Registry."
  type        = string
}

variable "location" {
  description = "Azure region where the Azure Container Registry is deployed."
  type        = string
}

variable "sku" {
  description = "SKU for the Azure Container Registry."
  type        = string
}

variable "task_name" {
  description = "Name of the Azure Container Registry Task that builds the application image."
  type        = string
}

variable "image_name" {
  description = "Docker image repository and tag produced by the Azure Container Registry Task."
  type        = string
}

variable "repository_url" {
  description = "Git repository URL used as the Azure Container Registry Task context."
  type        = string
}

variable "repository_branch" {
  description = "Git branch used by the Azure Container Registry Task context and source trigger."
  type        = string
}

variable "docker_context_path" {
  description = "Path inside the repository that contains the Docker build context."
  type        = string
}

variable "git_pat" {
  description = "Personal access token used by Azure Container Registry Task to access the Git repository."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to the Azure Container Registry and its task."
  type        = map(string)
}
