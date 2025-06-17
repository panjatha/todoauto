# resource "azurerm_key_vault" "keymandeep" {
#   for_each = var.keymandeep
#   name                        = each.value.mandeepvault
#   location                    = each.value.location
#   resource_group_name         = each.value.rgname
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   sku_name                    = "standard"
#   purge_protection_enabled    = true
#   soft_delete_retention_days  = 20


#   }





resource "azurerm_linux_virtual_machine" "vmname" {
  for_each                        = var.vmname
  name                            = each.value.linuxVM
  resource_group_name             = each.value.rgname
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.example[each.key].id
  ]



  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  custom_data = base64encode(each.value.custom_data)
}





