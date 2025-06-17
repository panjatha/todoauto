resource "azurerm_key_vault" "keymandeep" {
  for_each                   = var.keymandeep
  name                       = each.value.mandeepvault
  location                   = each.value.location
  resource_group_name        = each.value.rgname
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 20
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
        "Get",
    "List" ,
       "Set" ,
       "Delete",
       "Recover",
       "Backup" ,
       "Restore",
       "Purge"
    ]
  }

}


resource "azurerm_key_vault_secret" "username" {
  for_each = var.keymandeep
  name = each.value.secretname
  value = var.keyusername
  key_vault_id = azurerm_key_vault.keymandeep[each.key].id
  
}

resource "azurerm_key_vault_secret" "password" {
  for_each = var.keymandeep
  name = each.value.secret2name
  value = var.keypassword
  key_vault_id = azurerm_key_vault.keymandeep[each.key].id
  
}
