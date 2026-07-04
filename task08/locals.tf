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
  kubernetes_deployment_name = var.docker_image_name
  kubernetes_secret_name     = "redis-secret"
  kubernetes_service_name    = var.docker_image_name
  secret_provider_class_name = "azure-kvname"

  legacy_kubernetes_deployment_name = "${var.docker_image_name}-deployment"
  legacy_kubernetes_secret_name     = "${var.docker_image_name}-redis"
  legacy_kubernetes_service_name    = "${var.docker_image_name}-service"
  legacy_secret_provider_class_name = "${var.docker_image_name}-kv-secrets"
}
