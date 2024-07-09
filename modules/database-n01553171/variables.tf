variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
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

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}
