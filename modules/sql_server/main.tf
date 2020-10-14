resource "azurerm_sql_server" "sql_server" {
  lifecycle {
    ignore_changes = [
      node_taints,
      node_count
    ]
  }
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.region
  version                      = var.version
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
}

  
