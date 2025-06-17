resource "azurerm_mssql_database" "msqlserverdatabase" {
    for_each = var.msqlserverdatabase
  name         = each.value.databasename
  server_id    = data.azurerm_mssql_server.datasqlserver[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
 
}