component "deployment_catalog_registration" {
  source = "./module"

  inputs = {
    tfe_organization = var.tfe_organization

    module_catalog = var.module_catalog
    stack_catalog  = var.stack_catalog
  }

  providers = {
    tfe = provider.tfe.client
  }
}