variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "environment_location" {
  type    = string
  default = "West Europe"
}

variable "aks_name" {
  type = string
}

variable "aks_rg" {
  type = string
}

variable "akv_name" {
  type = string
}

variable "akv_rg" {
  type = string
}

variable "istio_gateway_pip" {
  type = string
}

variable "env_domain_name" {
  type = string
}

variable "env_domain_rg" {
  type = string
}
