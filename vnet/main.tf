variable "location" {
  type    = string
  default = "east us"
}
variable "rgName" {
  type    = string
  default = "KFSLNTHBRSG01"
}
variable "hub_vnet_name" {
  type    = string
  default = "KFSLNTHBVNT01"
}
variable "hub_vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}
variable "hub_subnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}
variable "environment_name" {
  type    = string
  default = "dev_1"
}
variable "backendstorage" {
  type    = string
  default = "cloudlegonewstorage"
}
variable "backendcontainer" {
  type    = string
  default = "tfstate"
}

terraform {
  backend "azurerm" {

  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "HUBResourceGroup" {
  location = var.location
  name     = var.rgName
}
resource "azurerm_virtual_network" "hubvnet" {
  name                = var.hub_vnet_name
  location            = var.location
  resource_group_name = var.rgName
  address_space       = [var.hub_vnet_address_space]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = var.environment_name
  }
}
resource "azurerm_network_security_group" "HUBNSG" {
  location            = var.location
  name                = "NSG01"
  resource_group_name = var.rgName
  tags = {
    environment = var.environment_name
  }
}
resource "azurerm_subnet" "hubsubnet" {
  name                 = "hubsubnet1"
  resource_group_name  = var.rgName
  virtual_network_name = azurerm_virtual_network.hubvnet.name
  address_prefixes     = [var.hub_subnet_address_space]
}
resource "azurerm_subnet_network_security_group_association" "hub_subnet_hub_nsg" {
  network_security_group_id = azurerm_network_security_group.HUBNSG.id
  subnet_id                 = azurerm_subnet.hubsubnet.id
}