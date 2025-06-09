resource "azurerm_mssql_database" "example" {
  name         = var.sqldatabase
  server_id    = var.serverid
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
 
}