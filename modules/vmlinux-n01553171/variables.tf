variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "linux_vms" {
  description = "A map of Linux VMs"
  type        = map(string)
}

variable "vm_size" {
  description = "The size of the VMs"
  type        = string
}

variable "boot_diagnostics_storage_uri" {
  description = "The URI of the storage account for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}

variable "av_set_name" {
  description = "A map of tags to assign to the resources"
  type        = string
}

variable "admin_username" {
  type        = string
}

variable "admin_password" {
  type        = string
}

variable "linux_vm_names" {
  description = "List of Linux VM names"
  type        = list(string)
}

variable "ssh_private_key_path" {
  type        = string
}
