// DNS Zone
resource "azurerm_dns_zone" "public_dns_zone" {
  name                = var.public_dns_zone
  resource_group_name = azurerm_resource_group.services.name
  tags                = local.default_tags
}
