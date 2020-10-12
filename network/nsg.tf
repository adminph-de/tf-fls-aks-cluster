#Create NSG for default Subnet
resource "azurerm_network_security_group" "default-nsg" {
  name                = "default-p-nsg"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name

  security_rule {
    name                       = "bastion-in-allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bastion-control-in-allow"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "4443"]
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

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
    name                       = "bastion-vnet-out-allow"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = ["22", "3389"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "bastion-azure-out-allow"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
}

#Accosiate NSG with default Subnet
resource "azurerm_subnet_network_security_group_association" "default-sub-nsg" {
  subnet_id                 = azurerm_subnet.default-subnet.id
  network_security_group_id = azurerm_network_security_group.default-nsg.id
}