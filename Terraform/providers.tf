terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
  subscription_id = "b5cedc24-5bf7-4266-a3c8-c8ab9149b4fe" #support.gigaspaces.com
}