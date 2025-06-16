data "azurerm_public_ip" "publicip" {
    for_each = var.azurerm_nic
  name                = each.value.publicip
  resource_group_name = each.value.rgname
}

data "azurerm_subnet" "subnetname" {
    for_each = var.azurerm_nic
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rgname
}