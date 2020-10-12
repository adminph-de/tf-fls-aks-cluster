#Create NSG for default Subnet
resource "azurerm_network_security_group" "default-nsg" {
  name                = var.vnet-default-nsg
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name

  security_rule {
    name                       = "bastion-in-deny"
    priority                   = 900
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "k8s-nodes-out-allow"
    priority                   = 850
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_ranges         = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
  security_rule {
    name                       = "k8s-nodes-out-deny"
    priority                   = 900
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_ranges         = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}