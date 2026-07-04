output "aci_fqdn" {
  description = "FQDN of the application running in Azure Container Instance."
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the application running in Azure Kubernetes Service."
  value       = data.kubernetes_service.app.status[0].load_balancer[0].ingress[0].ip
}
