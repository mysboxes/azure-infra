variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "env_name" {
  type        = string
  default     = ""
  description = "Live empty to use terraform.workspace"
}

variable "environment_location" {
  type    = string
  default = "West Europe"
}

variable "vnet_rg" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "aks_subnet_name" {
  type = string
}

variable "env_domain_rg" {
  type = string
}

variable "env_domain_name" {
  type = string
}

variable "aks_version" {
  type    = string
  default = "1.29.4"
}
