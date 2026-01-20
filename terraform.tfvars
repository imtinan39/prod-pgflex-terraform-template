# =========================
# GLOBAL
# =========================
resource_group_name = "rg-prod-pgflex"
location            = "eastus"

tags = {
  env   = "prod"
  app   = "drupal"
  owner = "DI"
}

# =========================
# NETWORK
# =========================
vnet_name = "vnet-prod"

vnet_address_space = [
  "10.10.0.0/16"
]

pg_subnet_name = "snet-prod-pgflex"

pg_subnet_prefixes = [
  "10.10.2.0/24"
]

# =========================
# PRIVATE DNS
# =========================
private_dns_zone_name = "privatelink.postgres.database.azure.com"

# =========================
# POSTGRES FLEXIBLE SERVER
# =========================
# MUST be globally unique
server_name = "utk-prod-pgflex-001"

administrator_login    = "pgadmin"
administrator_password = "REPLACE_WITH_STRONG_PASSWORD"

postgres_version = "16"

# General Purpose SKU for prod
sku_name   = "GP_Standard_D2s_v3"
storage_mb = 65536   # 64 GB

backup_retention_days        = 7
geo_redundant_backup_enabled = false
storage_auto_grow_enabled    = true

# Optional AZ pinning (set to "1", "2", or "3" if needed)
zone = null

# =========================
# POSTGRES PARAMETERS
# =========================
server_parameters = {
  log_min_duration_statement = "500"
  log_checkpoints            = "on"
}
