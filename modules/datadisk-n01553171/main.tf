# Create managed disks
resource "azurerm_managed_disk" "datadisks" {
  count                = 4
  name                 = "${var.vm_names[count.index]}-datadisk-${count.index}"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Attach disks to Linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "linux_datadisk_attach" {
  count              = length(var.linux_vm_ids)
  managed_disk_id    = azurerm_managed_disk.datadisks[count.index].id
  virtual_machine_id = var.linux_vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}

# Attach disks to Windows VM
resource "azurerm_virtual_machine_data_disk_attachment" "windows_datadisk_attach" {
  count              = length(var.windows_vm_ids)
  managed_disk_id    = azurerm_managed_disk.datadisks[count.index + length(var.linux_vm_ids)].id 
  virtual_machine_id = var.windows_vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}