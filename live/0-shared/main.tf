locals {
  services_rg       = var.shared_services_rg_name
  services_location = var.shared_services_location
  services_kv_name  = "shared-services-${random_integer.key_vault_name_suffix.result}"
  default_tags = {
    "managed-by"   = "terraform"
    "project-name" = "azure-infra"
    "infra-layer"  = "live/0-shared"
  }
}

resource "azurerm_resource_group" "services" {
  name     = local.services_rg
  location = local.services_location
  tags     = local.default_tags
}

# // Dev ACR
# resource "azurerm_container_registry" "dev_acr" {
#   name                          = local.dev_acr["name"]
#   resource_group_name           = azurerm_resource_group.services.name
#   location                      = azurerm_resource_group.services.location
#   sku                           = local.dev_acr["sku"]
#   zone_redundancy_enabled       = false
#   admin_enabled                 = true
#   public_network_access_enabled = local.dev_acr["pub_net_access"]
#   tags                          = local.default_tags
#   trust_policy = [
#     {
#       enabled = false
#     },
#   ]
# }
#
# // Prod ACR
# resource "azurerm_container_registry" "prod_acr" {
#   name                          = local.prod_acr["name"]
#   resource_group_name           = azurerm_resource_group.services.name
#   location                      = azurerm_resource_group.services.location
#   sku                           = local.prod_acr["sku"]
#   zone_redundancy_enabled       = false
#   admin_enabled                 = true
#   public_network_access_enabled = local.prod_acr["pub_net_access"]
#   tags                          = local.default_tags
#   trust_policy = [
#     {
#       enabled = false
#     },
#   ]
# }
#
# // Azure Log Analytics Workspace
# resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
#   name                = local.log_analytics_workspace["name"]
#   location            = azurerm_resource_group.services.location
#   resource_group_name = azurerm_resource_group.services.name
#   sku                 = local.log_analytics_workspace["sku"]
#   retention_in_days   = local.log_analytics_workspace["retention_in_days"]
# }
