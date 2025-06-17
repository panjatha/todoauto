resource "azurerm_public_ip" "publicip" {
    for_each = var.publicip
  name                = each.value.publicname
  resource_group_name = each.value.rgname
  location            = each.value.location
  allocation_method   = each.value.allocation_method
sku = each.value.sku

}