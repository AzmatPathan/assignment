variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_names" {
  description = "List of VM names"
  type        = list(string)
}

variable "linux_vm_ids" {
  description = "List of IDs for Linux VMs"
  type        = list(string)
}

variable "windows_vm_ids" {
  description = "List of IDs for Windows VMs"
  type        = list(string)
}