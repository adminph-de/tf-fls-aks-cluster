locals {
  bastion-name    = "AzureBastionSubnet"
  firwall-name    = "AzureFirewallSubnet"
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

##### ADDED SUBNET ######
##### CHECK: variables.tf BEFORE YOU ADD NEW SUBNETS ######

#resource "azurerm_subnet" "subnet-example-1" {
#  name                 = "shared__192_168_160_32__27"
#  resource_group_name  = azurerm_resource_group.example.name
#  virtual_network_name = azurerm_virtual_network.example.name
#  address_prefix       = "192.168.160.32/27"
#}