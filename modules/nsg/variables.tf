# File: modules/nsg/variables.tf
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "allow_rdp" {
  type    = bool
  default = false
}

variable "allow_ssh" {
  type    = bool
  default = false
}