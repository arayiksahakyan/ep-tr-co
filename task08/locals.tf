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
  kubernetes_deployment_name = "${var.docker_image_name}-deployment"
  kubernetes_secret_name     = "${var.docker_image_name}-redis"
  kubernetes_service_name    = "${var.docker_image_name}-service"
  secret_provider_class_name = "${var.docker_image_name}-kv-secrets"

  kubernetes_app_instances = {
    canonical = {
      deployment_name = var.docker_image_name
      label           = var.docker_image_name
      service_name    = var.docker_image_name
    }
    named = {
      deployment_name = local.kubernetes_deployment_name
      label           = local.kubernetes_deployment_name
      service_name    = local.kubernetes_service_name
    }
  }
}
