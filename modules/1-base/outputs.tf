output "env_domain_name" {
  value = local.env_domain_name
}

output "env_domain_rg" {
  value = local.env_domain_rg
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_rg" {
  value = azurerm_resource_group.network_rg.name
}

output "aks_subnet_name" {
  value = azurerm_subnet.aks_subnet.name
}
