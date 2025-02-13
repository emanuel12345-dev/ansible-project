# File: main.tf
# This is the main configuration file that brings everything together

provider "azurerm" {
  features {}

  subscription_id = "7e8e2543-8ca2-46e1-b1f9-fe1d1aad72ee"
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "multi-region-infrastructure"
  location = "eastus"
}

# Create VNets
module "vnet_eastus" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  vnet_name          = "vnet-eastus"
  address_space      = ["10.1.0.0/16"]
  subnet_name        = "subnet-eastus"
  subnet_prefix      = "10.1.1.0/24"
}

module "vnet_westeurope" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westeurope"
  vnet_name          = "vnet-westeurope"
  address_space      = ["10.2.0.0/16"]
  subnet_name        = "subnet-westeurope"
  subnet_prefix      = "10.2.1.0/24"
}

module "vnet_southeastasia" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "southeastasia"
  vnet_name          = "vnet-southeastasia"
  address_space      = ["10.3.0.0/16"]
  subnet_name        = "subnet-southeastasia"
  subnet_prefix      = "10.3.1.0/24"
}

module "nsg_eastus" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  nsg_name           = "nsg-eastus"
  allow_ssh          = true    # Allow SSH for Linux VM
}

module "nsg_westeurope" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westeurope"
  nsg_name           = "nsg-westeurope"
  allow_rdp          = true    # Allow RDP for Windows VM
}

module "nsg_southeastasia" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "southeastasia"
  nsg_name           = "nsg-southeastasia"
  allow_rdp          = true    # Allow RDP for Windows VM
}

# Update VM modules to include NSG associations
module "vm_eastus" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  vm_name            = "vm-eastus"
  subnet_id          = module.vnet_eastus.subnet_id
  nsg_id             = module.nsg_eastus.nsg_id    # Add NSG association
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  os_type           = "linux"
  custom_script     = filebase64("modules/vm/scripts/install_ansible_winrm.sh")
}

module "vm_westeurope" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westeurope"
  vm_name            = "vm-westeurope"
  subnet_id          = module.vnet_westeurope.subnet_id
  nsg_id             = module.nsg_westeurope.nsg_id    # Add NSG association
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  os_type           = "windows"
}

module "vm_southeastasia" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "southeastasia"
  vm_name            = "vm-southeastasia"
  subnet_id          = module.vnet_southeastasia.subnet_id
  nsg_id             = module.nsg_southeastasia.nsg_id    # Add NSG association
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  os_type           = "windows"
}

# Create VNet Peerings
module "peering_eastus_westeurope" {
  source              = "./modules/peering"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_1_name         = module.vnet_eastus.vnet_name
  vnet_1_id           = module.vnet_eastus.vnet_id
  vnet_2_name         = module.vnet_westeurope.vnet_name
  vnet_2_id           = module.vnet_westeurope.vnet_id
}

module "peering_eastus_southeastasia" {
  source              = "./modules/peering"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_1_name         = module.vnet_eastus.vnet_name
  vnet_1_id           = module.vnet_eastus.vnet_id
  vnet_2_name         = module.vnet_southeastasia.vnet_name
  vnet_2_id           = module.vnet_southeastasia.vnet_id
}

module "peering_westeurope_southeastasia" {
  source              = "./modules/peering"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_1_name         = module.vnet_westeurope.vnet_name
  vnet_1_id           = module.vnet_westeurope.vnet_id
  vnet_2_name         = module.vnet_southeastasia.vnet_name
  vnet_2_id           = module.vnet_southeastasia.vnet_id
}