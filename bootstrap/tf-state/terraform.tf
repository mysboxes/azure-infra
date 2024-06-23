terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "= 3.109.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "= 2.52.0"
    }
    random = {
      source = "hashicorp/random"
      version = "= 3.6.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azure-infra"
    storage_account_name = "azureinfra2185"
    container_name       = "tfstate"
    key                  = "bootstrap/tf-state.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  use_oidc        = true
  features {}
}
