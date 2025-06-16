terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "9fdd2e5e-e538-4a7d-b874-b787c2a93b94"
}
