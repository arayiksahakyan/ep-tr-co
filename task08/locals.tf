locals {
  rg_name       = "${var.name_prefix}-rg"
  aci_name      = "${var.name_prefix}-ci"
  acr_name      = "${replace(var.name_prefix, "-", "")}cr"
  aks_name      = "${var.name_prefix}-aks"
  keyvault_name = "${var.name_prefix}-kv"
  redis_name    = "${var.name_prefix}-redis"

  acr_task_name              = "${var.name_prefix}-acr-build"
  aci_dns_name_label         = lower(local.aci_name)
  app_image_name             = "${var.docker_image_name}:${var.image_tag}"
  container_name             = var.docker_image_name
  kubernetes_deployment_name = "redis-flask-app"
  kubernetes_secret_name     = "redis-secrets"
  kubernetes_service_name    = "redis-flask-app-service"
  secret_provider_class_name = "redis-flask-app-kv-integration"
}
