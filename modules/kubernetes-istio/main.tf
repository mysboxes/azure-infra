locals {
  chart_repo     = "https://istio-release.storage.googleapis.com/charts"
  base_namespace = "istio-system"
}

resource "kubernetes_namespace" "istio_base_namespace" {
  metadata {
    name = local.base_namespace
  }
  lifecycle {
    ignore_changes = [metadata[0].labels]
  }
}

resource "helm_release" "istio-base" {
  depends_on       = [kubernetes_namespace.istio_base_namespace]
  name             = "istio-base"
  repository       = local.chart_repo
  chart            = "base"
  version          = var.istio_version
  namespace        = local.base_namespace
  force_update     = true
  wait             = true
  create_namespace = false
}

resource "helm_release" "istiod" {
  depends_on       = [kubernetes_namespace.istio_base_namespace, helm_release.istio-base]
  name             = "istiod"
  repository       = local.chart_repo
  chart            = "istiod"
  version          = var.istio_version
  namespace        = local.base_namespace
  force_update     = true
  wait             = true
  create_namespace = false
}

resource "helm_release" "istio-ingressgateway" {
  depends_on       = [helm_release.istiod]
  name             = "istio-ingressgateway"
  repository       = local.chart_repo
  chart            = "gateway"
  version          = var.istio_version
  namespace        = local.base_namespace
  force_update     = true
  wait             = true
  create_namespace = true
  cleanup_on_fail  = true
  timeout          = 900
  values           = [file("${path.module}/istio-ingressgateway.values.yaml")]
  set {
    name  = "service.loadBalancerIP"
    value = var.gateway_ip_address
  }
}

resource "kubernetes_secret" "tls_wildcard" {
  metadata {
    name      = "tls-wildcard"
    namespace = local.base_namespace
  }
  data = {
    "tls.key" = var.wildcard_tls_key
    "tls.crt" = var.wildcard_tls_crt
  }
  type = "kubernetes.io/tls"
}
