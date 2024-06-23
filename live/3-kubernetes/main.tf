locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/3-kubernetes"
  }
  env_name            = terraform.workspace
  environment_rg_name = "az-infra-base-${local.env_name}"
  aks_rg_name         = "az-infra-aks-${local.env_name}"
  aks_name            = "az-infra-aks-${local.env_name}"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}

data "azurerm_key_vault" "shared_kv" {
  name                = var.shared_services_akv
  resource_group_name = var.shared_services_rg_name
}

data "azurerm_key_vault_certificate_data" "tls_wildcard" {
  name         = "tls-wildcard-${local.env_name}"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
}

data "azurerm_dns_zone" "dns_zone" {
  name                = var.public_dns_zone
  resource_group_name = var.shared_services_rg_name
}
