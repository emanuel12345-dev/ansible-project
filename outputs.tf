output "linux_vm_public_ip" {
  value = module.vm_eastus.public_ip_address
  description = "Public IP of the Linux VM in East US"
}

output "windows_vm_westeurope_public_ip" {
  value = module.vm_westeurope.public_ip_address
  description = "Public IP of the Windows VM in West Europe"
}

output "windows_vm_southeastasia_public_ip" {
  value = module.vm_southeastasia.public_ip_address
  description = "Public IP of the Windows VM in Southeast Asia"
}