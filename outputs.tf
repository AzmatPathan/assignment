output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "nsg_name" {
  value = module.network.nsg_name
}

output "storage_account_name" {
  value = module.common_services.storage_account_name
}

output "log_analytics_name" {
  value = module.common_services.log_analytics_name
}

output "recovery_vault_name" {
  value = module.common_services.recovery_vault_name
}

output "vm_hostnames" {
  value = module.linux_vms.vm_hostnames
}
# VM FQDNs
output "vm_fqdns" {
  value = module.linux_vms.vm_fqdns
}

# Private IP Addresses
output "private_ip_addresses" {
  value = module.linux_vms.vm_private_ips
}

# Public IP Addresses
output "public_ip_addresses" {
  value = module.linux_vms.vm_public_ips
}


# VM Hostnames
output "vm_hostnames_windows" {
  value = module.windows_vm.vm_hostname_windows
}

# VM FQDNs
output "vm_fqdns_windows" {
  value = module.windows_vm.vm_fqdn_windows
}

# Private IP Addresses
output "private_ip_addresses_windows" {
  value = module.windows_vm.vm_private_ip_windows
}

# Public IP Addresses
output "public_ip_addresses_windows" {
  value = module.windows_vm.vm_public_ip_windows
}

# Public IP Addresses
output "datadisk_names" {
    value = module.data_disks.datadisk_names
}

output "linux_vm_nic_ids" {
  value = module.linux_vms.linux_vm_nic_ids
}



