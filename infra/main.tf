resource "azurerm_resource_group" "rg" {
  name     = "rg-gitops-platform"
  location = "westeurope"

  tags = {
    project     = "azure-gitops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "sttfstateyavuz2026"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "germanywestcentral"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    project     = "azure-gitops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}