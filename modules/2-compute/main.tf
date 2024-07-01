locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/compute"
    "env-name"     = local.env_name
  }
  env_name    = var.env_name == "" ? terraform.workspace : var.env_name
  env_rg_name = "az-infra-compute-${local.env_name}"
  aks_name    = "az-infra-aks-${local.env_name}"
  aks_version = var.aks_version
}

resource "azurerm_resource_group" "env_rg" {
  name     = local.env_rg_name
  location = var.environment_location
  tags     = local.default_tags
}
