locals {
  manifest_files = [
    "deployment.yaml",
    "hpa.yaml",
    "service.yaml",
  ]
}

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

resource "kubectl_manifest" "app" {
  for_each = toset(local.manifest_files)
  yaml_body = templatefile(
    "${path.module}/manifests/${each.value}",
    {
      namespace = var.namespace
    }
  )
}

resource "kubectl_manifest" "gateway" {
  yaml_body = templatefile(
    "${path.module}/manifests/gateway.yaml",
    {
      namespace = var.namespace,
      dns_name  = var.dns_name
    }
  )
}

resource "kubectl_manifest" "virtual_service" {
  yaml_body = templatefile(
    "${path.module}/manifests/virtualService.yaml",
    {
      namespace = var.namespace,
      dns_name  = var.dns_name
    }
  )
}
