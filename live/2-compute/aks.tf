resource "azurerm_resource_group" "aks_rg" {
  name     = local.aks_rg_name
  location = var.environment_location
  tags     = local.default_tags
}

data "azurerm_resource_group" "network_rg" {
  name = local.environment_rg_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.network_rg.name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "aks"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.network_rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
      network_profile[0].nat_gateway_profile
    ]
  }
  name                      = local.aks_name
  location                  = azurerm_resource_group.aks_rg.location
  resource_group_name       = azurerm_resource_group.aks_rg.name
  dns_prefix                = "${local.aks_name}-dns"
  kubernetes_version        = local.aks_version
  automatic_channel_upgrade = "patch"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  run_command_enabled       = false
  identity {
    type = "SystemAssigned"
  }
  /*
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.aks_admin_group_object_ids
  }
  role_based_access_control_enabled = true
  azure_policy_enabled              = var.azure_policy_enabled
  */
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "1m"
  }

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2as_v4"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
    os_disk_size_gb     = 42
    os_sku              = "AzureLinux"
    vnet_subnet_id      = data.azurerm_subnet.aks_subnet.id
    tags                = {}
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    ip_versions       = ["IPv4"]
    outbound_type     = "userAssignedNATGateway"
    nat_gateway_profile {
      idle_timeout_in_minutes = 4
    }
    #    dns_service_ip    = var.dns_service_ip
    #    pod_cidr          = var.aks_pod_cidr
    #    service_cidr      = var.aks_service_cidr
  }
}

resource "azurerm_role_assignment" "aks_subnet" {
  scope                = data.azurerm_subnet.aks_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
