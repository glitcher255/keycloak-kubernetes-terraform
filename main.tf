resource "azurerm_resource_group" "rg_main" {
  name     = "RG_main"
  location = var.location
}

module "vnet" {
    location = var.location
    rg_name = azurerm_resource_group.rg_main.name
    source = "./modules/vnet"
    depends_on = [ azurerm_resource_group.rg_main ]
}

module "cluster" {
    location = var.location
    rg_name = azurerm_resource_group.rg_main.name
    subnet_id = module.vnet.subnet_id
    source = "./modules/cluster"
    depends_on = [ module.vnet ]
}

module "NSG" {
    location = var.location
    rg_name = azurerm_resource_group.rg_main.name
    subnet_id = module.vnet.subnet_id
    source = "./modules/NSG"
    depends_on = [ module.cluster ]
}

output "kube_config" {
  value     = module.cluster.kube_config
  sensitive = true
}