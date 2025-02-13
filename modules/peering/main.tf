# File: modules/peering/main.tf
resource "azurerm_virtual_network_peering" "peering_1_to_2" {
  name                         = "${var.vnet_1_name}-to-${var.vnet_2_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.vnet_1_name
  remote_virtual_network_id    = var.vnet_2_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "peering_2_to_1" {
  name                         = "${var.vnet_2_name}-to-${var.vnet_1_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.vnet_2_name
  remote_virtual_network_id    = var.vnet_1_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}