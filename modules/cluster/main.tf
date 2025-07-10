resource "azurerm_kubernetes_cluster" "aks" {
  name                = "AKS_cluster"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "myaks"

  default_node_pool {
    name                  = "default"
    vm_size               = "Standard_B2s"
    auto_scaling_enabled  = true
    min_count             = 1
    max_count             = 3
    type                  = "VirtualMachineScaleSets"
    vnet_subnet_id        = var.subnet_id
    os_disk_size_gb       = 32 #64
    #os_disk_type = "Ephemeral" #testing only (not with b2s)
  }
    identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}