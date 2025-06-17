resource "azurerm_mssql_server" "msqlserver" {
for_each = var.msqlserver
  name                         = each.value.servername
  resource_group_name          = each.value.rgname
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password

  
}