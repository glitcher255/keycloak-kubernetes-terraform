resource "azurerm_network_security_group" "nsg_rules" {
  name                 = "nsg_allow_inbound"
  location             = var.location
  resource_group_name  = var.rg_name
#   security_rule = {}  <replaced with nsg_rule_1
}

resource "azurerm_network_security_rule" "nsg_rule_1" {
  name                        = "AllowSpecificPorts"
  resource_group_name         = var.rg_name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22","80", "5005"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg_rules.name
}

resource "azurerm_subnet_network_security_group_association" "subet_and_nsg_association" {
  network_security_group_id = azurerm_network_security_group.nsg_rules.id
  subnet_id = var.subnet_id
}