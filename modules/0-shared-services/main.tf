locals {
  services_rg       = var.shared_services_rg_name
  services_location = var.shared_services_location
  services_kv_name  = "shared-services-${random_integer.key_vault_name_suffix.result}"
  acr_name          = "azinfra${random_integer.acr_name_suffix.result}"
  env_name          = var.env_name == "" ? terraform.workspace : var.env_name
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/0-shared-services"
  }
}

resource "azurerm_resource_group" "services" {
  name     = local.services_rg
  location = local.services_location
  tags     = local.default_tags
}
