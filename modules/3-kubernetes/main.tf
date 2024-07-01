locals {
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/kubernetes"
    "env-name"     = local.env_name
  }
  env_name            = var.env_name == "" ? terraform.workspace : var.env_name
  environment_rg_name = "az-infra-base-${local.env_name}"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.aks_rg
}

data "azurerm_key_vault" "shared_kv" {
  name                = var.akv_name
  resource_group_name = var.akv_rg
}

data "azurerm_key_vault_certificate_data" "tls_wildcard" {
  name         = "tls-wildcard-${local.env_name}"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
}

data "azurerm_dns_zone" "dns_zone" {
  name                = var.env_domain_name
  resource_group_name = var.env_domain_rg
}
