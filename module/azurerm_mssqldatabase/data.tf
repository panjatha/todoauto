data "azurerm_mssql_server" "datasqlserver" {
    for_each = var.msqlserverdatabase
  name                = each.value.server_id
  resource_group_name = each.value.rgname
}