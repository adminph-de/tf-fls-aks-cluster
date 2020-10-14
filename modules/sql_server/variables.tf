variable "name" {
  type        = string
  description = "Name of the SQL Server"
}

variable "resource_group_name" {
  type        = string
  description = "Resourcegroup Name where the SQL server gets deployed"
}

variable "region" {
  type        = string
  description = "Azuer region"
}

variable "version" {
  type        = string
  description = "SQL Server version"
  default     = "12.0"
}

variable "admin_login" {
  type        = string
  description = "SQL Server Administratior Username"
  default     = "sqladmin"
}

variable "admin_password" {
  type        = string
  description = "SQL Server Administrator Password"
}