locals {
  manifest_files = [
    "details.Deployment.yaml",
    "details.Service.yaml",
    "details.ServiceAccount.yaml",
    "productpage-v1.Deployment.yaml",
    "productpage.Service.yaml",
    "productpage.ServiceAccount.yaml",
    "ratings.Deployment.yaml",
    "ratings.Service.yaml",
    "ratings.ServiceAccount.yaml",
    "reviews-v1.Deployment.yaml",
    "reviews-v2.Deployment.yaml",
    "reviews-v3.Deployment.yaml",
    "reviews.Service.yaml",
    "reviews.ServiceAccount.yaml"
  ]
}

resource "kubernetes_namespace" "bookinfo_namespace" {
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

resource "kubectl_manifest" "bookinfo" {
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
