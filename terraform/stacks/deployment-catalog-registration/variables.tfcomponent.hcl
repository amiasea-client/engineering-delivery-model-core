variable "tfe_organization" {
  type = string
}

variable "tfe_token" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "module_catalog" {
  type = list(object({
    name             = string
    provider         = string
    repository       = string
    source_directory = string
  }))
}

variable "stack_catalog" {
  type = list(object({
    name             = string
    repository       = string
    working_directory = string
  }))
}