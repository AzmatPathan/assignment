
output "vm_hostname_windows" {
  value = azurerm_virtual_machine.vm_windows.name
}

output "vm_fqdn_windows" {
  value = azurerm_public_ip.ip_windows.fqdn
}

output "vm_private_ip_windows" {
  value = azurerm_network_interface.nic_windows.private_ip_address
}

output "vm_public_ip_windows" {
  value = azurerm_public_ip.ip_windows.ip_address
}

output "windows_vm_id" {
  value = [azurerm_virtual_machine.vm_windows.id]
}  
