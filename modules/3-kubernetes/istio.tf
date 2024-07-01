module "istio" {
  source             = "./modules/kubernetes-istio"
  gateway_ip_address = var.istio_gateway_pip
  wildcard_tls_key   = data.azurerm_key_vault_certificate_data.tls_wildcard.key
  wildcard_tls_crt   = data.azurerm_key_vault_certificate_data.tls_wildcard.pem
}
