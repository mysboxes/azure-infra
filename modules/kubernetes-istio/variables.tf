variable "istio_version" {
  type        = string
  description = "Istio chart version"
  default     = "1.22.1"
}

variable "gateway_ip_address" {
  type        = string
  description = "Gateway IP address"
  default     = ""
}

variable "public_gateway_ip" {
  type        = bool
  default     = true
  description = "Is gateway address public?"
}

variable "wildcard_tls_key" {
  type      = string
  sensitive = true
}

variable "wildcard_tls_crt" {
  type      = string
  sensitive = true
}
