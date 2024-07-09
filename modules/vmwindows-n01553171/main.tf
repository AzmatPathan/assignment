resource "azurerm_availability_set" "av_set_windows" {
  name                = var.av_set_name
  location            = var.location
  resource_group_name = var.rg_name
  managed             = true
}

resource "azurerm_network_interface" "nic_windows" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip_windows.id
  }
}

resource "azurerm_public_ip" "ip_windows" {
  name                = "${var.vm_name}-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  domain_name_label   = var.vm_name
}

resource "azurerm_virtual_machine" "vm_windows" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.rg_name
  availability_set_id = azurerm_availability_set.av_set_windows.id
  network_interface_ids = [
    azurerm_network_interface.nic_windows.id
  ]

  vm_size = var.vm_size

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware_windows" {
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_virtual_machine.vm_windows.id
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "Exclusions": {
            "Extensions": ".log;.ldf",
            "Paths": "D:\\IISlogs;D:\\CustomFolder",
            "Processes": "mssence.svc"
        },
        "RealtimeProtectionEnabled": true,
        "ScheduledScanSettings": {
            "isEnabled": true,
            "scanType": "Quick",
            "day": "7",
            "time": "120"
        }
    }
  SETTINGS
}
