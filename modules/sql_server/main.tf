resource "azurerm_sql_server" "sql" {
  lifecycle {
    ignore_changes = [
      node_taints,
      node_count
    ]
  }
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.region
  version                      = var.sku
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
}