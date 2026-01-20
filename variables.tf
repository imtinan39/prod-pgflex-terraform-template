/* =========================
   EXISTING RG + VNET
   ========================= */
variable "resource_group_name" {
  type        = string
  description = "Pre-existing resource group name."
}

variable "vnet_name" {
  type        = string
  description = "Pre-existing VNet name (in the same RG)."
}

variable "location" {
  type        = string
  description = "Azure region (must match the RG region)."
  default     = "eastus"
}

variable "tags" {
  type    = map(string)
  default = {}
}

/* =========================
   CREATE SUBNET (DELEGATED)
   ========================= */
variable "pg_subnet_name" {
  type        = string
  description = "Name of the subnet to create for PostgreSQL Flexible Server."
  default     = "snet-pgflex"
}

variable "pg_subnet_prefixes" {
  type        = list(string)
  description = "CIDR(s) for the new delegated subnet (must not overlap existing subnets)."
}

/* =========================
   PRIVATE DNS (CREATE)
   ========================= */
variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS zone name for Postgres private access."
  default     = "privatelink.postgres.database.azure.com"
}

/* =========================
   POSTGRES FLEXIBLE SERVER
   ========================= */
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

/* =========================
   SERVER PARAMETERS
   ========================= */
variable "server_parameters" {
  type    = map(string)
  default = {}
}
