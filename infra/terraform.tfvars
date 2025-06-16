rg = {
    "rg1" = {
        rgname = "mandeeprg"
        location = "East US"
    }
}

vnet = {
    "vnet1" = {
        vnetname = "mandeepvnet"
        location = "East US"
        rgname = "mandeeprg"
        address_space = ["10.0.0.0/16"]
    }
}

subnet = {
    "subnet1" = {
        subnetname = "mandeepsubnet"
        rgname ="mandeeprg"
        vnetname = "mandeepvnet"
        address_prefixes = ["10.0.0.0/24"]
    }
        "subnet2" = {
        subnetname = "mandeepsubnet2"
        rgname ="mandeeprg"
        vnetname = "mandeepvnet"
        address_prefixes = ["10.0.1.0/24"]
}
}

publicip = {
    "public1" ={
publicname = "publicip1"
rgname ="mandeeprg"
location ="East US"
allocation_method ="Static"
    }
    "public2"={
publicname = "publicip2"
rgname ="mandeeprg"
location ="East US"
allocation_method ="Static"
    }
}

azurerm_nic = {
    "nic1" = {
        nicname = "mandeepnic1"
        rgname = "mandeeprg"
        location = "East US"
       ipconfigname = "internal"
       private_ip_address_allocation = "Dynamic"
       publicip = "publicip1"
       vnet ="mandeepvnet"
       subnet ="mandeepsubnet"
    }
"nic2" = {
          nicname = "mandeepnic1"
        rgname = "mandeeprg"
        location = "East US"
       ipconfigname = "internal"
       private_ip_address_allocation = "Dynamic"
       publicip = "publicip2"
       vnet ="mandeepvnet"
       subnet ="mandeepsubnet"
}
    }

vmname = {
  "VM1" = {
    linuxVM                       = "firstVM"
    rgname                        = "mandeeprg"
    location                      = "East US"
    size                          = "Standard_F2"
    admin_username                = "azureadmin"
    admin_password                = "Waheguru@123"
    disable_password_authentication = false
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
    azurerm_nic  = "mandeepnic1"
    custom_data = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y curl
      curl -s https://deb.nodesource.com/setup_16.x | sudo bash -
      sudo apt install -y nodejs
      mkdir -p /home/azureuser/app
      cd /home/azureuser/app
      npm install
      npm run build
    EOT
    
  }

  "VM2" = {
    linuxVM                       = "secondVM"
    rgname                        = "mandeeprg"
    location                      = "East US"
    size                          = "Standard_F2"
    admin_username                = "azureadmin"
    admin_password                = "Waheguru@123"
    disable_password_authentication = false
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-focal"
    sku                           = "20_04-lts"
    version                       = "latest"
    azurerm_nic  = "mandeepnic2"
    custom_data = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y python3 python3-pip curl unixodbc unixodbc-dev gnupg
      curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
      curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
      apt-get update -y
      ACCEPT_EULA=Y apt-get install -y msodbcsql17
    EOT
    
  }
}
