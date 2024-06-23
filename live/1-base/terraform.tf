terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.109.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.6.2"
    }
    acme = {
      source  = "vancluever/acme"
      version = "=2.23.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "=4.0.5"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azure-infra"
    storage_account_name = "azureinfra2185"
    container_name       = "tfstate"
    key                  = "live/1-base.tfstate"
  }
}

provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  use_oidc                   = true
  skip_provider_registration = true
  features {}
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
#   server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}
