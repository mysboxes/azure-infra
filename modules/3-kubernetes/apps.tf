/*
module "petstore" {
  depends_on = [module.istio]
  source     = "./modules/kubernetes-petstore"
  dns_name   = "petstore.${data.azurerm_dns_zone.dns_zone.name}"
}

module "bookinfo" {
  depends_on = [module.istio]
  source     = "./modules/kubernetes-bookinfo"
  dns_name   = "bookinfo.${data.azurerm_dns_zone.dns_zone.name}"
}

module "podinfo" {
  depends_on = [module.istio]
  source     = "./modules/kubernetes-podinfo"
  dns_name   = "podinfo.${data.azurerm_dns_zone.dns_zone.name}"
}
*/
