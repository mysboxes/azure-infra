data "azurerm_public_ip" "istio_gateway_public_ip" {
  name                = var.istio_gateway_pip_name
  resource_group_name = var.istio_gateway_pip_rg
}

module "istio" {
  source             = "../../modules/kubernetes-istio"
  gateway_ip_address = data.azurerm_public_ip.istio_gateway_public_ip.ip_address
  wildcard_tls_key   = data.azurerm_key_vault_certificate_data.tls_wildcard.key
  wildcard_tls_crt   = data.azurerm_key_vault_certificate_data.tls_wildcard.pem
}
