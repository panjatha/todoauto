resource "azurerm_virtual_network" "example" {
  name                = var.vnet
  location            = var.location
  resource_group_name = var.rgname
  address_space = var.address_space

  }
