resource "azurerm_availability_set" "av_set" {
  name                = var.av_set_name
  location            = var.location
  resource_group_name = var.rg_name
  managed             = true
}

resource "azurerm_public_ip" "ip" {
  for_each = var.linux_vms

  name                = "${each.key}-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${each.key}-dns"
}

resource "azurerm_network_interface" "nic" {
  for_each = var.linux_vms

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip[each.key].id
  }
}

resource "azurerm_virtual_machine" "vm" {
  for_each            = var.linux_vms
  name                = "${each.key}-linux"
  location            = var.location
  resource_group_name = var.rg_name
  availability_set_id = azurerm_availability_set.av_set.id
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  vm_size = var.vm_size

  storage_os_disk {
    name              = "${each.key}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${each.key}-linux"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = var.linux_vms
  name                = "networkWatcherAgent-${each.key}"
  virtual_machine_id  = azurerm_virtual_machine.vm[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = var.linux_vms
  name                = "azureMonitorAgent-${each.key}"
  virtual_machine_id  = azurerm_virtual_machine.vm[each.key].id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  type_handler_version = "1.7"
}