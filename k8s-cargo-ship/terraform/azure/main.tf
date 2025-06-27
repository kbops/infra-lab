provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-resource-group"
  location = local.region
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = local.tags
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = local.name
  kubernetes_version  = local.cluster_version
  dns_prefix          = "aks-${local.name}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  default_node_pool {
    name       = "defaultnp"
    vm_size    = "Standard_DS2_v2"
    node_count = 1
    node_labels = {
      "agentpool" = "defaultnp"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "spot_pool" {
  name                  = "spotnp"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"

  priority        = "Spot"
  eviction_policy = "Delete"
  spot_max_price  = -1
  node_count      = 1
  node_taints     = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]

  tags = {
    Environment = "Dev"
    NodeType    = "Spot"
  }
}
