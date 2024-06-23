variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
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

variable "contact_email" {
  type = string
}

variable "contact_name" {
  type = string
}
