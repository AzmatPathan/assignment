output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "virtual_network_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet_address_space" {
  value = azurerm_subnet.subnet.address_prefixes
}