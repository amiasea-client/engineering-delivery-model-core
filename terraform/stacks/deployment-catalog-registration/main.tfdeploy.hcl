store "varset" "amiasea" {
  name     = "amiasea"
  category = "terraform"
}

upstream_input "module_catalog_identification" {
  type   = "stack"
  source = "app.terraform.io/${store.varset.amiasea.stable.tfe-organization}/Engineering Delivery Model/deployment-catalog-identification-module-catalog"
}

upstream_input "stack_catalog_identification" {
  type   = "stack"
  source = "app.terraform.io/${store.varset.amiasea.stable.tfe-organization}/Engineering Delivery Model/deployment-catalog-identification-stack-catalog"
}

deployment "default" {
  inputs = {
    tfe_organization = store.varset.amiasea.stable.tfe-organization

    tfe_token = store.varset.amiasea.tfe_token

    module_catalog = upstream_input.module_catalog_identification.modules
    stack_catalog  = upstream_input.stack_catalog_identification.stacks
  }
}