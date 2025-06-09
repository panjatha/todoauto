module "rgname" {
    source = "../module/azurerm_Resorucegroup"
    resource_group =  "todoautomation"
    location = "East US"
    
  
}

module "vnet" {
    depends_on = [ module.rgname ]
  source = "../module/azurerm_VNET" 
  vnet = "todoautovnet"
  location = "East US"
  rgname = "todoautomation"
  address_space = ["10.0.0.0/16"]
}

module "frontendsubnet" {
  depends_on = [ module.rgname,module.vnet ]
  source = "../module/azurerm_subnet"
subnet = "todoautosubnet-frontend"
rgname = "todoautomation"
vnet = "todoautovnet"
address_prefixes = ["10.0.1.0/24"]
}

module "backendsubnet" {
    depends_on = [ module.rgname,module.vnet ]
  source = "../module/azurerm_subnet"

subnet = "todoautosubnet-backend"
rgname = "todoautomation"
vnet = "todoautovnet"
address_prefixes = ["10.0.0.0/24"]
}



module "mssqlserver" {
  depends_on = [ module.rgname ]
  source = "../module/azurerm_mssqlserver"
  msqlserver = "todoautomssqlserver45"
  rgname = "todoautomation"
  location = "Central India"
}

module "mssqldatabase" {
  source = "../module/azurerm_mssqldatabase"
  sqldatabase = "todoautosqldatabase88"
  serverid = "/subscriptions/9fdd2e5e-e538-4a7d-b874-b787c2a93b94/resourceGroups/todoautomation/providers/Microsoft.Sql/servers/todoautomssqlserver45"
  
}

module "frontendVM" {
  depends_on = [ module.frontendsubnet  ]
  azurermpublicip = "frontendpublicip"
  source = "../module/azurerm_VM"
  azurerm_network_interface = "networkinterface78"
  location = "East US"
  rgname = "todoautomation"
  linuxVM = "todoautovm-frontend"
  admin_username = "linuxfrontend"
  admin_password = "Waheguru@123"
subnet_id = "/subscriptions/9fdd2e5e-e538-4a7d-b874-b787c2a93b94/resourceGroups/todoautomation/providers/Microsoft.Network/virtualNetworks/todoautovnet/subnets/todoautosubnet-frontend"
custom_data = base64encode(<<EOF
#cloud-config
package_update: true
runcmd:
  # Install Node.js 16.x and npm
  - curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
  - apt-get install -y nodejs

  # Install nginx
  - apt-get install -y nginx
  - systemctl enable nginx
  - systemctl start nginx

  # Verify installations (optional)
  - node -v > /home/azureuser/node-version.txt
  - npm -v > /home/azureuser/npm-version.txt
  - systemctl status nginx > /home/azureuser/nginx-status.txt
EOF
  )

}


module "backendVM" {
  depends_on = [  module.backendsubnet ]
  azurermpublicip = "backendpublicip"
  source = "../module/azurerm_VM"
  azurerm_network_interface = "networkinterface73"
  location = "East US"
  rgname = "todoautomation"
  linuxVM = "todoautovm-backend"
  admin_username = "linuxbackend"
  admin_password = "Waheguru@123"
subnet_id = "/subscriptions/9fdd2e5e-e538-4a7d-b874-b787c2a93b94/resourceGroups/todoautomation/providers/Microsoft.Network/virtualNetworks/todoautovnet/subnets/todoautosubnet-backend"
custom_data =  base64encode(<<EOF
#cloud-config
package_update: true
runcmd:
  # Install Python and pip
  - apt-get install -y python3 python3-pip
  - python3 --version > /home/azureuser/python-version.txt
  - pip3 --version > /home/azureuser/pip-version.txt

  # Install ODBC dependencies
  - apt-get install -y unixodbc unixodbc-dev

  # Add Microsoft SQL Server ODBC repository
  - curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
  - curl https://packages.microsoft.com/config/debian/10/prod.list -o /etc/apt/sources.list.d/mssql-release.list

  # Install Microsoft ODBC Driver for SQL Server
  - apt-get update
  - ACCEPT_EULA=Y apt-get install -y msodbcsql17
EOF
)
}