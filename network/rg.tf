resource "azurerm_resource_group" "vnet-rg" {
  name     = var.vnet-resource-group
  location = var.vnet-location
  tags = {
    Department  = "Cloud Center of Exelence (CCoE)"
    Enviornment = "PROD"
    Description = "Deployed by Terraform (IaC)"
  }
}