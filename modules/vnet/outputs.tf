output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the created Virtual Network"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the created Virtual Network"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the created subnet"
}