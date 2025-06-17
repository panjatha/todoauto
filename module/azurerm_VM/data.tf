data "azurerm_network_interface" "example" {
  for_each            = var.vmname
  name                = each.value.azurerm_nic
  resource_group_name = each.value.rgname
}


data "azurerm_key_vault" "keyvault" {
  for_each            = var.vmname
  name                = each.value.keyvault
  resource_group_name = each.value.rgname

}

data "azurerm_key_vault_secret" "username" {
  for_each     = var.vmname
  name         = each.value.secretname
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}


data "azurerm_key_vault_secret" "password" {
  for_each     = var.vmname
  name         = each.value.secret2name
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

# data "azurerm_client_config" "current" {}
