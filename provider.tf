terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "e4017399-a8f8-47ab-b5cb-54fc05394426"
}

