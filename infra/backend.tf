terraform {
  backend "azurerm" {
    resource_group_name  = "rg-gitops-platform"
    storage_account_name = "sttfstateyavuz2026"
    container_name        = "tfstate"
    key                    = "portfolio.terraform.tfstate"
  }
}