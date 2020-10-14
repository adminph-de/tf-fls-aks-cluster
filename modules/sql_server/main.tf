resource "azurerm_sql_server" "sql" {

  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.region
  version                      = var.sku
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password

}