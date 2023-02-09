variable "aks_cluster" {
  type = map(any)
  default = {
    resource_group_name              = "csm-bbw"
    resource_group_location          = "eastus"
    cluster_name                     = "shmulik-test-2"
    dns_prefix                       = "shmulik-test-2"
    node_pool_name                   = "bbwnodepool"
    vm_size                          = "Standard_B4ms"
    sku_tier                         = "Paid"
    enable_auto_scaling              = "true"
    agent_count                      = 1
    min_count                        = 3
    max_count                        = 5
    http_application_routing_enabled = true
    log_analytcs_name                = "shmulik-test-2"
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
