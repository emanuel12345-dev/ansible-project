# File: modules/vnet/variables.tf
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the VNet will be created"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_prefix" {
  type        = string
  description = "Address prefix for the subnet"
}
