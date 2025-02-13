# File: modules/nsg/outputs.tf
output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}