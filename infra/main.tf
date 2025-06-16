module "rgname" {
    source = "../module/azurerm_Resorucegroup"
rg = var.rg
    
  
}

module "vnet" {
    depends_on = [ module.rgname ]
  source = "../module/azurerm_VNET" 
  vnet = var.vnet
}

module "subnet" {
  depends_on = [ module.rgname,module.vnet ]
  source = "../module/azurerm_subnet"
  subnet = var.subnet
}

module "azurermnic" {
  depends_on = [ module.rgname,module.vnet,module.subnet ]
  source = "../module/azurerm_nic"
  azurerm_nic = var.azurerm_nic
  
}

module "vmname" {
  depends_on = [ module.rgname,module.vnet,module.subnet,module.azurermnic ]
  source = "../module/azurerm_VM"
vmname = var.vmname
  
}