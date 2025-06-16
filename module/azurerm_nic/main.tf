resource "azurerm_network_interface" "azurerm_nic" {
  for_each = var.azurerm_nic
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.rgname
  ip_configuration {
    
    name                          = each.value.ipconfigname
    subnet_id                     = data.azurerm_subnet.subnetname[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id         = data.azurerm_public_ip.publicip[each.key].id

  }
}
