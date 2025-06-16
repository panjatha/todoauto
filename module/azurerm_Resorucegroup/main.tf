resource "azurerm_resource_group" "rg" {
    for_each = var.rg
    name = each.value.rgname
    location = each.value.location
  
}