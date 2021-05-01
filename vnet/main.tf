variable "location"{
  type = string
}
variable "rgName"{
  type = string
}
variable "backendstorage" {
  type = string
}
variable "backendcontainer" {}
variable "backendkey" {}

terraform {
  backend "azurerm" {
    resource_group_name  = var.rgName
    storage_account_name = var.backendstorage
    container_name       = var.backendcontainer
    key                  = var.backendkey
  }
}
provider "azurerm" {
	 features {}
}
resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = var.location
  resource_group_name = var.rgName
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Production"
  }
}
