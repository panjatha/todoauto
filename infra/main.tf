module "rgname" {
  source = "../module/azurerm_Resorucegroup"
  rg     = var.rg


}

module "vnet" {
  depends_on = [module.rgname]
  source     = "../module/azurerm_VNET"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.rgname, module.vnet]
  source     = "../module/azurerm_subnet"
  subnet     = var.subnet
}

module "publicip" {
  depends_on = [module.rgname]
  source     = "../module/publicip"
  publicip   = var.publicip
}

module "azurermnic" {
  depends_on  = [module.rgname, module.vnet, module.subnet, module.publicip]
  source      = "../module/azurerm_nic"
  azurerm_nic = var.azurerm_nic

}

module "vmname" {
  depends_on = [module.rgname, module.vnet, module.subnet, module.azurermnic, module.keymandeep]
  source     = "../module/azurerm_VM"
  vmname     = var.vmname


}

module "msqlserver" {
  depends_on = [module.rgname]
  source     = "../module/azurerm_mssqlserver"
  msqlserver = var.msqlserver

}

module "msqlserverdatabase" {
  depends_on         = [module.msqlserver]
  source             = "../module/azurerm_mssqldatabase"
  msqlserverdatabase = var.msqlserverdatabase

}

module "keymandeep" {
  depends_on = [  module.rgname]
  source = "../module/azurerm_keyvault"
  keymandeep = var.keymandeep
  keypassword = var.keypassword
  keyusername = var.keyusername
  
}


