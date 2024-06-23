variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "contact_email" {
  type = string
}

variable "contact_name" {
  type = string
}

variable "environment_location" {
  type    = string
  default = "West Europe"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.64.0.0/16"]
}

variable "aks_snet_address_prefixes" {
  type    = list(string)
  default = ["10.64.64.0/18"]
}

variable "public_dns_zone" {
  type = string
}

variable "shared_services_rg" {
  type = string
}

variable "shared_services_key_vault" {
  type = string
}
