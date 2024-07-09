variable "log_analytics_name" {
  description = "The name of the Log Analytics workspace"
  type        = string
}

variable "recovery_vault_name" {
  description = "The name of the Recovery Services vault"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}
