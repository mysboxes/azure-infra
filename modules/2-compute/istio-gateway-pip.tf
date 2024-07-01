resource "azurerm_public_ip" "istio_gateway_public_ip" {
  depends_on          = [azurerm_kubernetes_cluster.aks]
  name                = "${local.aks_name}-istio-gateway"
  resource_group_name = lower(azurerm_kubernetes_cluster.aks.node_resource_group)
  location            = azurerm_kubernetes_cluster.aks.location
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_tags             = {}
  tags = {
    k8s-azure-cluster-name = local.aks_name
  }
}

data "azurerm_dns_zone" "dns_zone" {
  name                = var.env_domain_name
  resource_group_name = var.env_domain_rg
}

resource "azurerm_dns_a_record" "istio_gateway_wildcard" {
  name                = "*"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 900
  records             = [azurerm_public_ip.istio_gateway_public_ip.ip_address]
}
