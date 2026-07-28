data "tfe_github_app_installation" "tfe_cloud_app" {
  name = var.tfe_organization
}

resource "tfe_registry_module" "modules" {
  for_each = {
    for module in var.module_catalog :
    module.name => module
  }

  organization    = var.tfe_organization
  name            = each.value.name
  module_provider = each.value.provider
  registry_name   = "private"

  vcs_repo {
    display_identifier         = "${var.tfe_organization}/${each.value.repository}"
    identifier                 = "${var.tfe_organization}/${each.value.repository}"
    tags                       = true
    tag_prefix                 = "${each.value.name}-v"
    source_directory           = each.value.source_directory
    github_app_installation_id = data.tfe_github_app_installation.tfe_cloud_app.id
  }
}

resource "tfe_stack" "stacks" {
  for_each = {
    for stack in var.stack_catalog :
    stack.name => stack
  }

  name              = each.value.name
  project_id        = data.tfe_project.engineering_delivery_model.id
  working_directory = each.value.working_directory
  
  trigger_patterns = [
    "${each.value.working_directory}/**/*"
  ]

  vcs_repo {
    identifier                 = "${var.tfe_organization}/${each.value.repository}"
    branch                     = "main"
    github_app_installation_id = data.tfe_github_app_installation.tfe_cloud_app.id
  }
}

data "tfe_project" "engineering_delivery_model" {
  name         = "Engineering Delivery Model"
  organization = var.tfe_organization
}