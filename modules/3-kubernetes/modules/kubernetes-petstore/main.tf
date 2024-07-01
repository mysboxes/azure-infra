resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
    labels = {
      istio-injection = "enabled"
    }
  }
  lifecycle {
    ignore_changes = [metadata[0].labels]
  }
}

resource "helm_release" "petstore" {
  depends_on       = [kubernetes_namespace.namespace]
  name             = var.name
  chart            = "${path.module}/charts/petstore"
  namespace        = var.namespace
  force_update     = true
  wait             = true
  create_namespace = false
  cleanup_on_fail  = true
  timeout          = 900
  set {
    name  = "conf.SWAGGER_URL"
    value = "https://${var.dns_name}"
  }
  set {
    name  = "conf.SWAGGER_BASE_PATH"
    value = var.http_base_path
  }
}

resource "kubectl_manifest" "istio_gateway" {
  depends_on = [helm_release.petstore]
  yaml_body = templatefile(
    "${path.module}/gateway.yaml",
    {
      name      = var.name,
      namespace = var.namespace,
      dns_name  = var.dns_name
    }
  )
}

resource "kubectl_manifest" "istio_virtual_service" {
  depends_on = [helm_release.petstore]
  yaml_body = templatefile(
    "${path.module}/virtualService.yaml",
    {
      name      = var.name,
      namespace = var.namespace,
      dns_name  = var.dns_name
    }
  )
}
