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

variable "shared_services_rg_name" {
  type    = string
  default = "shared-services"
}

variable "shared_services_akv" {
  type    = string
}

variable "shared_services_location" {
  type    = string
  default = "West Europe"
}

variable "istio_gateway_pip_name" {
  type = string
}

variable "istio_gateway_pip_rg" {
  type = string
}

variable "public_dns_zone" {
  type = string
}
