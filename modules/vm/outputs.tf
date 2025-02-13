# File: modules/vm/outputs.tf
output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the VM"
}

output "vm_private_ip" {
  value = var.os_type == "windows" ? azurerm_windows_virtual_machine.windows_vm[0].private_ip_address : azurerm_linux_virtual_machine.linux_vm[0].private_ip_address
  description = "The private IP address of the VM"
}