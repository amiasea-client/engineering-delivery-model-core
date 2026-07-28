required_providers {
  tfe = {
    source  = "hashicorp/tfe"
    version = "~> 0.79.0"
  }
}

provider "tfe" "client" {
  config {
    hostname = "app.terraform.io"
    token    = var.tfe_token
  }
}