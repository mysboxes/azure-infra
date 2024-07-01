resource "random_integer" "acr_name_suffix" {
  min  = 100
  max  = 999
  seed = local.env_name
}

resource "azurerm_container_registry" "acr" {
  name                          = local.acr_name
  resource_group_name           = azurerm_resource_group.services.name
  location                      = azurerm_resource_group.services.location
  sku                           = "Standard"
  zone_redundancy_enabled       = false
  admin_enabled                 = false
  public_network_access_enabled = true
  tags                          = local.default_tags
  trust_policy = [
    {
      enabled = false
    },
  ]
}
