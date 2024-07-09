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

variable "av_set_name" {
  description = "The name of the availability set"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username"
  type        = string
}

variable "admin_password" {
  description = "The admin password"
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

variable "ssh_private_key_path" {
  description = "Path to the SSH private key file"
  type        = string
}