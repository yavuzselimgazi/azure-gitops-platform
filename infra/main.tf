resource "azurerm_resource_group" "rg" {
  name     = "rg-gitops-platform"
  location = "westeurope"

  tags = {
    project     = "azure-gitops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}