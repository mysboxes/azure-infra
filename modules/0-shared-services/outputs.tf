output "shared_services_rg" {
  value = azurerm_resource_group.services.name
}

output "public_dns_zone" {
  value = azurerm_dns_zone.public_dns_zone.name
}

output "shared_services_key_vault" {
  value = azurerm_key_vault.shared_services_key_vault.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}
