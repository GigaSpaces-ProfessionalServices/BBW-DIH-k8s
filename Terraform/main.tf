resource "azurerm_resource_group" "rg" {
  location = var.aks_cluster.resource_group_location
  name     = var.aks_cluster.resource_group_name
}

resource "azurerm_log_analytics_workspace" "bbw" {
  name                = var.aks_cluster.log_analytcs_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.aks_cluster.log_analytcs_sku
  retention_in_days   = var.aks_cluster.log_analytcs_retention_in_days
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location                         = azurerm_resource_group.rg.location
  name                             = var.aks_cluster.cluster_name
  resource_group_name              = azurerm_resource_group.rg.name
  dns_prefix                       = var.aks_cluster.dns_prefix
  sku_tier                         = var.aks_cluster.sku_tier
  http_application_routing_enabled = var.aks_cluster.http_application_routing_enabled
  tags                             = var.tags

  default_node_pool {
    name                = var.aks_cluster.node_pool_name
    zones               = var.zones
    vm_size             = var.aks_cluster.vm_size
    enable_auto_scaling = var.aks_cluster.enable_auto_scaling
    max_count           = var.aks_cluster.max_count
    min_count           = var.aks_cluster.min_count
  }
  
  
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  identity {
    type = "SystemAssigned"
  }
 
}

