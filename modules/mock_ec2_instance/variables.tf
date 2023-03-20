variable "bootstrap_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "instances" {
  description = "List of instance meta-data objects"
  type = list(object({
    name     = string
    key_name = string
  }))
}


variable "spot_instances" {
  description = "List of spot instance meta-data objects"
  type = list(object({
    name     = string
    key_name = string
  }))
}
