resource "azurerm_container_registry" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build" {
  name                  = var.task_name
  container_registry_id = azurerm_container_registry.main.id
  tags                  = var.tags

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "${var.repository_url}#${var.repository_branch}:${var.docker_context_path}"
    context_access_token = var.git_pat
    image_names          = [var.image_name]
    push_enabled         = true
  }

  source_trigger {
    name           = "source-commit"
    events         = ["commit"]
    repository_url = var.repository_url
    source_type    = "Github"
    branch         = var.repository_branch
    enabled        = true

    authentication {
      token      = var.git_pat
      token_type = "PAT"
    }
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "build" {
  container_registry_task_id = azurerm_container_registry_task.build.id
}
