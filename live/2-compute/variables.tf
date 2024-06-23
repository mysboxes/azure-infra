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

variable "aks_version" {
  type    = string
  default = "1.29.4"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.64.0.0/16"]
}

variable "aks_snet_address_prefixes" {
  type    = list(string)
  default = ["10.64.64.0/18"]
}

variable "shared_services_rg_name" {
  type    = string
  default = "shared-services"
}

variable "shared_services_location" {
  type    = string
  default = "West Europe"
}

variable "public_dns_zone" {
  type = string
}
