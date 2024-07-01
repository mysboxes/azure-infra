data "azurerm_key_vault" "shared_services_key_vault" {
  name                = var.shared_services_key_vault
  resource_group_name = var.shared_services_rg
}

resource "tls_private_key" "letsencrypt_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "letsencrypt_private_key" {
  name         = "letsencrypt-private-key-${local.env_name}"
  value        = tls_private_key.letsencrypt_private_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.shared_services_key_vault.id
  tags         = local.default_tags
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.letsencrypt_private_key.private_key_pem
  email_address   = var.contact_email
}

# locals {
#   camel_k_namespaces = ["one", "two", "three"]
#   extra_san_names = flatten([[for namespace in local.camel_k_namespaces : ["*.${namespace}.${data.azurerm_dns_zone.public_dns_zone.name}"]]])
#   extra_san_names = [local.env_domain_name]
# }

resource "acme_certificate" "tls_wildcard_certificate" {
  common_name                  = "*.${local.env_domain_name}"
  subject_alternative_names    = [local.env_domain_name]
  key_type                     = 4096
  account_key_pem              = acme_registration.reg.account_key_pem
  min_days_remaining           = 30 # Won't request new certificate until current certificate is > 29 days old
  disable_complete_propagation = false
  pre_check_delay              = 20
  dns_challenge {
    provider = "azuredns"
    config = {
      AZURE_POLLING_INTERVAL     = 12
      AZURE_PROPAGATION_TIMEOUT  = 30
      AZURE_TTL                  = 1
      AZURE_AUTH_METHOD          = "cli"
      AZURE_RESOURCE_GROUP       = local.env_domain_rg
      AZURE_SUBSCRIPTION_ID      = var.subscription_id
      AZURE_TENANT_ID            = var.tenant_id
      LEGO_DISABLE_CNAME_SUPPORT = true
    }
  }
}

resource "azurerm_key_vault_certificate" "tls_wildcard_certificate" {
  name         = local.tls_wildcard_cert_name
  key_vault_id = data.azurerm_key_vault.shared_services_key_vault.id
  certificate {
    contents = acme_certificate.tls_wildcard_certificate.certificate_p12
    password = ""
  }
  tags = local.default_tags
}
