output "aci_fqdn" {
  description = "FQDN of the application running in Azure Container Instance."
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the application running in Azure Kubernetes Service."
  value       = jsondecode(data.kubectl_manifest.app_service.json).status.loadBalancer.ingress[0].ip
}
