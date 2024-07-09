output "vm_hostnames" {
  value = [for vm in azurerm_virtual_machine.vm : vm.name]
}

output "vm_fqdns" {
  value = { for ip in azurerm_public_ip.ip : ip.name => ip.fqdn }
}

output "vm_private_ips" {
  value = { for nic in azurerm_network_interface.nic : nic.name => nic.private_ip_address }
}

output "vm_public_ips" {
  value = { for ip in azurerm_public_ip.ip : ip.name => ip.ip_address }
}

output "linux_vm_names" {
  value = [for vm_name, _ in var.linux_vms : vm_name]
}

output "linux_vm_ids" {
  value = [for vm_name in var.linux_vm_names : azurerm_virtual_machine.vm[vm_name].id]
}

output "linux_vm_nic_ids" {
  value = {
    for vm_name, vm_config in var.linux_vms :
    vm_name => azurerm_network_interface.nic[vm_name].id
  }
}


