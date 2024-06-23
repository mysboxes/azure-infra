locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/1-base"
  }
  environment_rg_name       = "az-infra-base-${terraform.workspace}"
  vnet_name                 = "az-infra-net-${terraform.workspace}"
  nat_pip_name              = "az-infra-nat-pip-${terraform.workspace}"
  nat_gw_name               = "az-infra-nat-gw-${terraform.workspace}"
  vnet_address_space        = var.vnet_address_space
  aks_snet_address_prefixes = var.aks_snet_address_prefixes
  tls_wildcard_cert_name    = "tls-wildcard-${terraform.workspace}"
}
