locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/2-compute"
  }
  environment_rg_name       = "az-infra-base-${terraform.workspace}"
  aks_rg_name               = "az-infra-aks-${terraform.workspace}"
  vnet_name                 = "az-infra-net-${terraform.workspace}"
  aks_name                  = "az-infra-aks-${terraform.workspace}"
  aks_version               = var.aks_version
  vnet_address_space        = var.vnet_address_space
  aks_snet_address_prefixes = var.aks_snet_address_prefixes
}
