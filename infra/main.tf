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

module "publicip2" {
    depends_on = [ module.rgname ]
    source = "../module/azurerm_publicip"
    azurermpublicip = "publicip"
    location = "East US"
    rgname = "todoautomation"
  
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
  source = "../module/azurerm_VM"
  azurerm_network_interface = "networkinterface78"
  location = "East US"
  rgname = "todoautomation"
  linuxVM = "todoautovm-frontend"
subnet_id = "/subscriptions/9fdd2e5e-e538-4a7d-b874-b787c2a93b94/resourceGroups/todoautomation/providers/Microsoft.Network/virtualNetworks/todoautovnet/subnets/todoautosubnet-frontend"


}


module "backendVM" {
  depends_on = [  module.backendsubnet ]
  source = "../module/azurerm_VM"
  azurerm_network_interface = "networkinterface73"
  location = "East US"
  rgname = "todoautomation"
  linuxVM = "todoautovm-backend"
subnet_id = "/subscriptions/9fdd2e5e-e538-4a7d-b874-b787c2a93b94/resourceGroups/todoautomation/providers/Microsoft.Network/virtualNetworks/todoautovnet/subnets/todoautosubnet-backend"

}