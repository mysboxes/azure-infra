output "istio_gateway_pip_name" {
  value = azurerm_public_ip.istio_gateway_public_ip.name
}

output "istio_gateway_pip_rg" {
  value = azurerm_public_ip.istio_gateway_public_ip.resource_group_name
}
