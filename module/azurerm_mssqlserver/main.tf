resource "azurerm_mssql_server" "example" {
  name                         = var.msqlserver
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "adminsql"
  administrator_login_password = "Waheguru@123"
  minimum_tls_version          = "1.2"

  
}