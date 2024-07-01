variable "name" {
  type    = string
  default = "petstore"
}

variable "namespace" {
  type    = string
  default = "petstore"
}

variable "dns_name" {
  type = string
}

variable "http_base_path" {
  type    = string
  default = "/v1"
}
