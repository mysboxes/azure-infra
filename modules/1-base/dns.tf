data "azurerm_dns_zone" "public_dns_zone" {
  name                = var.public_dns_zone
  resource_group_name = var.shared_services_rg
}

locals {
  env_domain_name  = var.dns_subdomain == "" ? data.azurerm_dns_zone.public_dns_zone.name : "${var.dns_subdomain}.${data.azurerm_dns_zone.public_dns_zone.name}"
  create_subdomain = var.dns_subdomain == "" ? false : true
  env_domain_rg    = var.dns_subdomain == "" ? data.azurerm_resource_group.shared_services.name : azurerm_resource_group.network_rg.name
}

// DNS Zone
resource "azurerm_dns_zone" "env_dns_zone" {
  count               = local.create_subdomain ? 1 : 0
  name                = local.env_domain_name
  resource_group_name = azurerm_resource_group.network_rg.name
  tags                = local.default_tags
}

resource "azurerm_dns_ns_record" "env_dns_zone" {
  count               = local.create_subdomain ? 1 : 0
  name                = var.dns_subdomain
  zone_name           = data.azurerm_dns_zone.public_dns_zone.name
  resource_group_name = data.azurerm_resource_group.shared_services.name
  ttl                 = 300
  records             = azurerm_dns_zone.env_dns_zone[0].name_servers
  tags                = local.default_tags
}
