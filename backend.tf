terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate_n01553171RG"
    storage_account_name = "tfstaten01553171sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
