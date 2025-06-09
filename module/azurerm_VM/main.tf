resource "azurerm_public_ip" "public" {
  name                = var.azurermpublicip
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"


}


resource "azurerm_network_interface" "nic" {
  name                = var.azurerm_network_interface
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.public.id

  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = var.linuxVM
  resource_group_name = var.rgname
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password =  var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

custom_data =  var.custom_data
}




  
