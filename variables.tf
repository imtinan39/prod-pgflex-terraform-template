variable "resource_group_name" {
  type        = string
  description = "Single resource group for all resources."
  default     = "rg-pgflex"
}

variable "location" {
  type        = string
  default     = "eastus"
}

variable "tags" {
  type    = map(string)
  default = {}
}

/* ================= NETWORK ================= */
variable "vnet_name" {
  type    = string
  default = "vnet-dev"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

variable "pg_subnet_name" {
  type    = string
  default = "snet-pgflex"
}

variable "pg_subnet_prefixes" {
  type    = list(string)
  default = ["10.10.2.0/24"]
}

/* ================= DNS ================= */
variable "private_dns_zone_name" {
  type    = string
  default = "privatelink.postgres.database.azure.com"
}

/* ================= POSTGRES ================= */
variable "server_name" {
  type        = string
  description = "PostgreSQL Flexible Server name (globally unique)."
}

variable "administrator_login" {
  type    = string
  default = "pgadmin"
}

variable "administrator_password" {
  type      = string
  sensitive = true
}

variable "postgres_version" {
  type    = string
  default = "16"
}

variable "sku_name" {
  type    = string
  default = "GP_Standard_D2s_v3"
}

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "geo_redundant_backup_enabled" {
  type    = bool
  default = false
}

variable "storage_auto_grow_enabled" {
  type    = bool
  default = true
}

variable "zone" {
  type    = string
  default = null
}

/* ================= PARAMETERS ================= */
variable "server_parameters" {
  type    = map(string)
  default = {}
}
