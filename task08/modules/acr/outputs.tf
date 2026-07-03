output "id" {
  description = "ID of the Azure Container Registry."
  value       = azurerm_container_registry.main.id
}

output "login_server" {
  description = "Login server of the Azure Container Registry."
  value       = azurerm_container_registry.main.login_server
}

output "admin_username" {
  description = "Admin username of the Azure Container Registry."
  value       = azurerm_container_registry.main.admin_username
}

output "admin_password" {
  description = "Admin password of the Azure Container Registry."
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "task_id" {
  description = "ID of the Azure Container Registry image build task."
  value       = azurerm_container_registry_task.build.id
}

output "task_schedule_id" {
  description = "ID of the Azure Container Registry task schedule run."
  value       = azurerm_container_registry_task_schedule_run_now.build.id
}
