output "log_analytics_name" {
  value = azurerm_log_analytics_workspace.log_analytics.name
}

output "recovery_vault_name" {
  value = azurerm_recovery_services_vault.recovery_vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "boot_diagnostics_storage_uri" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}