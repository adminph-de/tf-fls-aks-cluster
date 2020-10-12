locals {
  bastion-name    = "AzureBastionSubnet"
  firwall-name    = "AzureFirewallSubnet"

  ##Adding a new Subnet variable(s) definition
  # subnet-example-1-address-prefix = "10.3.36.64/26"
  # subnet-example-1-name           = "shared__192_168_160_32__27"
}
}
#Create VNet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_space       = [var.vnet-address-space]
  dns_servers         = var.vnet-dns-servers
}

#Create Subnet for Bastion Host
resource "azurerm_subnet" "subnet-bastion" {
  name                 = local.bastion-name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.bastion-subnet
}
#Create Default Subnet
resource "azurerm_subnet" "subnet-default" {
  name                 = var.default-name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.default-subnet
}
#Accosiate NSG with Default Subnet
resource "azurerm_subnet_network_security_group_association" "default-sub-nsg" {
  subnet_id                 = azurerm_subnet.subnet-default.id
  network_security_group_id = azurerm_network_security_group.default-nsg.id
}

##### ADDED SUBNET ######
##### CHECK: variables.tf and local variables BEFORE YOU ADD NEW SUBNETS ######

#resource "azurerm_subnet" "subnet-example-1" {
#  name                 = local.subnet-example-1-name
#  resource_group_name  = azurerm_resource_group.example.name
#  virtual_network_name = azurerm_virtual_network.example.name
#  address_prefix       = local.subnet-example-1-address-prefix
#}
#Accosiate NSG with Bastion Subnet
#resource "azurerm_subnet_network_security_group_association" "subnet-example-1-sub-nsg" {
#  subnet_id                 = azurerm_subnet.subnet-example-1.id
#  network_security_group_id = azurerm_network_security_group.default-nsg.id
#}