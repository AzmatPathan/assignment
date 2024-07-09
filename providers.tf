# Terraform provider-info
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.104.0"
    }
  }
}
# Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "d68cc1ed-e636-4344-a3f2-6da1b2086097"
}
