
terraform {
  backend "azurerm" {
    resource_group_name  = "32943"
    storage_account_name = "cloudlegonewstorage"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
