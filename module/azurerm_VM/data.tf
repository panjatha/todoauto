data "azurerm_network_interface" "example" {
    for_each = var.vmname
  name                = each.value.azurerm_nic
  resource_group_name = each.value.rgname
}