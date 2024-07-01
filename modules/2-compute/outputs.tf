output "istio_gateway_pip" {
  value = azurerm_public_ip.istio_gateway_public_ip.ip_address
}

output "aks_name" {
  value = local.aks_name
}

output "aks_rg" {
  value = azurerm_resource_group.env_rg.name
}

/*
output "istio_gateway_pip_name" {
  value = azurerm_public_ip.istio_gateway_public_ip.name
}

output "istio_gateway_pip_rg" {
  value = azurerm_public_ip.istio_gateway_public_ip.resource_group_name
}
*/
