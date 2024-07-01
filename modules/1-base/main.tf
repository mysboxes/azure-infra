locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/1-base"
    "env-name"     = local.env_name
  }
  env_name                  = var.env_name == "" ? terraform.workspace : var.env_name
  env_rg_name               = "az-infra-base-${local.env_name}"
  vnet_name                 = "az-infra-net-${local.env_name}"
  nat_pip_name              = "az-infra-nat-pip-${local.env_name}"
  nat_gw_name               = "az-infra-nat-gw-${local.env_name}"
  vnet_address_space        = var.vnet_address_space
  aks_snet_address_prefixes = var.aks_snet_address_prefixes
  tls_wildcard_cert_name    = "tls-wildcard-${local.env_name}"
}

resource "azurerm_resource_group" "network_rg" {
  name     = local.env_rg_name
  location = var.env_location
  tags     = local.default_tags
}

data "azurerm_resource_group" "shared_services" {
  name = var.shared_services_rg
}
