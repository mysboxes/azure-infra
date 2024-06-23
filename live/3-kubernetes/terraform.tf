terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.109.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.6.2"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "=2.0.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "=2.14.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azure-infra"
    storage_account_name = "azureinfra2185"
    container_name       = "tfstate"
    key                  = "live/3-kubernetes.tfstate"
  }
}

provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  use_oidc                   = true
  skip_provider_registration = true
  features {}
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
  #   registry {
  #     url      = "oci://${var.shared_acr_name}.azurecr.io/charts"
  #     username = "00000000-0000-0000-0000-000000000000"
  #     password = data.external.acr_access_token.result.token
  #   }
}
