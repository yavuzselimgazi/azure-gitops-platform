resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-gitops-platform"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksgitops"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2s_v7"
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  identity {
    type = "SystemAssigned"
  }

    network_profile {
    network_plugin = "azure"
    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
  }

  tags = {
    project     = var.project_name
    environment = "portfolio"
    managed_by  = "terraform"
  }
}