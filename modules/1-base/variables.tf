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

variable "env_name" {
  type        = string
  default     = ""
  description = "Live empty to use terraform.workspace"
}

variable "env_location" {
  type    = string
  default = "West Europe"
}

# Ranges https://www.davidc.net/sites/default/subnets/subnets.html?network=10.64.0.0&mask=11&division=39.f9c4627231
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

variable "dns_subdomain" {
  type    = string
  default = ""
}

variable "shared_services_rg" {
  type = string
}

variable "shared_services_key_vault" {
  type = string
}
