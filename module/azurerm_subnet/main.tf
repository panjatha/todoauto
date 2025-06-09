resource "azurerm_subnet" "example" {
  name                 = var.subnet
  resource_group_name  = var.rgname
  virtual_network_name = var.vnet
  address_prefixes     = var.address_prefixes
}