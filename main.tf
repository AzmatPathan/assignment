module "resource_group" {
  source = "./modules/rgroup-n01553171"
  resource_group_name = "rsgroup-assignment"
  location            = "Canada Central"
}

module "network" {
  source       = "./modules/network-n01553171"
  rg_name      = module.resource_group.name
  location     = module.resource_group.location
  vnet_name    = "n01553171-VNET"
  subnet_name  = "n01553171-SUBNET"
  nsg_name     = "n01553171-NSG"
  subnet_address_space       = ["10.0.0.0/24"]
  virtual_network_address_space = ["10.0.0.0/16"]
}

module "common_services" {
  source       = "./modules/common-n01553171"
  rg_name      = module.resource_group.name
  location     = module.resource_group.location
  storage_account_name = "n01553171storage"
  log_analytics_name     = "n01553171log"
  recovery_vault_name   = "n01553171vault"
}

module "linux_vms" {
  source                         = "./modules/vmlinux-n01553171"
  rg_name                        = module.resource_group.name
  location                       = module.resource_group.location
  subnet_id                      = module.network.subnet_id
  admin_username = "azureuser"
  admin_password = "Password1234!"
  linux_vms                             = { "linux-vm1" = "linux-vm1dns", 
                                           "linux-vm2" = "linux-vm2dns", 
                                           "linux-vm3" = "linux-vm3dns" }

  linux_vm_names  = module.linux_vms.linux_vm_names 
  av_set_name                    = "myAvailabilitySet"
  vm_size                        = "Standard_B1ms"
  boot_diagnostics_storage_uri   = module.common_services.boot_diagnostics_storage_uri
  ssh_private_key_path           = "/home/azmatpathan/id_rsa"

  tags                           = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Azmat Pathan"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "windows_vm" {
  source       = "./modules/vmwindows-n01553171"
  rg_name      = module.resource_group.name
  location     = module.resource_group.location
  subnet_id    = module.network.subnet_id
  av_set_name  = "n01553171AvSet"
  vm_name      = "n3171win"
  vm_size      = "Standard_B1ms"
  admin_username = "azureuser"
  admin_password = "Password1234!"
  ssh_private_key_path           = "/home/azmatpathan/id_rsa"
  
  boot_diagnostics_storage_uri = module.common_services.boot_diagnostics_storage_uri
  tags         = {
    Assignment   = "CCGC 5502 Automation Assignment"
    Name         = "Azmat Pathan"
    ExpirationDate = "2024-12-31"
    Environment  = "Learning"
  }
}

module "data_disks" {
  source       = "./modules/datadisk-n01553171"
  rg_name      = module.resource_group.name
  location     = module.resource_group.location
  vm_names     = concat(module.linux_vms.vm_hostnames, [module.windows_vm.vm_hostname_windows])
  linux_vm_ids = module.linux_vms.linux_vm_ids
  windows_vm_ids = module.windows_vm.windows_vm_id
}


module "load_balancer" {
  source = "./modules/loadbalancer-n01553171"
  rg_name = module.resource_group.name
  location = module.resource_group.location
  lb_name = "n01553171lb"
  lb_ip_name = "n01553171LBIP"
  vm_nics    = {
    for vm_name, nic_id in module.linux_vms.linux_vm_nic_ids :
    "vm${replace(vm_name, "linux-vm", "")}_nic" => nic_id
  }
  linux_vm_nic_ids = module.linux_vms.linux_vm_nic_ids
}

module "database" {
  source = "./modules/database-n01553171"
  rg_name = module.resource_group.name
  location = module.resource_group.location
  db_name = "n0153171db"
  admin_username = "azureuser"
  admin_password = "Password1234!"
  tags = {
      Assignment = "CCGC 5502 Automation Assignment"
      Name = "Azmat Pathan"
      ExpirationDate = "2024-12-31"
      Environment = "Learning"
    }
}
