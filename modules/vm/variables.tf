# File: modules/vm/variables.tf
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_D8s_v4"  # 8 cores instead of 16
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "os_type" {
  type = string
}

variable "custom_script" {
  type    = string
  default = ""
}
variable "nsg_id" {
  type        = string
  description = "ID of the Network Security Group to associate with the VM"
}