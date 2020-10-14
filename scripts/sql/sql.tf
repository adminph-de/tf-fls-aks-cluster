## Create a resource group to place resources
resource "azurerm_resource_group" "sql" {
  name     = "sql-shared-p"
  location = "westeurope"
  tags = {
    Department  = "Cloud Center of Exelence (CCoE)"
    Enviornment = "PROD"
    Description = "Deployed by Terraform (IaC)"
  }
}
## Create SQL Server (Paas)
module "sql_server" {
  source          = "git@github.com:adminph-de/tf-fls-aks-cluster.git//modules//sql_server?ref=cluster-v1.0"
  name            = "shared-sql01-p"
  resource_group_name  = azurerm_resource_group.sql.name
  region          = "westeurope"
  #version         = "2.0"
  admin_login     = "flsadmin"
  admin__password = "sql!Flsmidth,2020"
}