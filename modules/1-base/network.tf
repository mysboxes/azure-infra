resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = local.vnet_address_space
}

resource "azurerm_subnet" "aks_subnet" {
  depends_on           = [azurerm_virtual_network.vnet]
  name                 = "aks"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = local.aks_snet_address_prefixes
}

resource "azurerm_public_ip" "nat_gateway_public_ip" {
  name                = local.nat_pip_name
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "runtime_nat_gw" {
  name                    = local.nat_gw_name
  resource_group_name     = azurerm_resource_group.network_rg.name
  location                = azurerm_resource_group.network_rg.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ips" {
  nat_gateway_id       = azurerm_nat_gateway.runtime_nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "aks_sn_nat_gw" {
  subnet_id      = azurerm_subnet.aks_subnet.id
  nat_gateway_id = azurerm_nat_gateway.runtime_nat_gw.id
}
