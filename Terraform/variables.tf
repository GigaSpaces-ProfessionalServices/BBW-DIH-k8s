variable "aks_cluster" {
  type = map(any)
  default = {
    resource_group_name              = "csm-bbw"
    resource_group_location          = "eastus"
    cluster_name                     = "Shmulik"
    dns_prefix                       = "Shmulik"
    node_pool_name                   = "bbwnodepool"
    vm_size                          = "Standard_B4ms"        # Standard_B4ms: 4vCPU, 16GB   Standard_B8ms: 8vCPU, 32GB
    sku_tier                         = "Paid"
    enable_auto_scaling              = "true"
    agent_count                      = 1
    min_count                        = 3
    max_count                        = 5
    http_application_routing_enabled = true
    log_analytcs_name                = "Shmulik"
    log_analytcs_retention_in_days   = 30
    log_analytcs_sku                 = "PerGB2018"


  }
}

variable "zones" {
  default = ["1", "2", "3"]
}

variable "tags" {
  type = map(any)
  default = {

    Environment = "Development"
    Owner       = "Shmulik"
    Project     = "bbw"
    gspolicy    = "noprod"

  }
}
