resource "random_integer" "key_vault_name_suffix" {
  min  = 11
  max  = 99
  seed = terraform.workspace
}

resource "azurerm_key_vault" "shared_services_key_vault" {
  name                            = local.services_kv_name
  location                        = azurerm_resource_group.services.location
  resource_group_name             = azurerm_resource_group.services.name
  enabled_for_disk_encryption     = false
  enabled_for_deployment          = false
  enable_rbac_authorization       = true
  enabled_for_template_deployment = true
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  sku_name                        = "standard"
  tags                            = local.default_tags
  lifecycle {
    ignore_changes = [contact]
  }
}

resource "azurerm_key_vault_certificate_contacts" "contact" {
  key_vault_id = azurerm_key_vault.shared_services_key_vault.id
  contact {
    email = var.contact_email
    name  = var.contact_name
  }
}

data "azurerm_client_config" "current" {
}

resource "azurerm_role_assignment" "akv_sp" {
  scope                = azurerm_key_vault.shared_services_key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}
