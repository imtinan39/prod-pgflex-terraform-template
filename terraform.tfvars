resource_group_name = "rg-prod-pgflex"
vnet_name           = "practice"
location            = "westus"

pg_subnet_name     = "snet-prod-pgflex"
pg_subnet_prefixes = ["10.10.2.0/24"]

private_dns_zone_name = "privatelink.postgres.database.azure.com"

server_name = "utk-prod-pgflex-001"  # globally unique
administrator_login    = ""
administrator_password = ""

postgres_version = "16"
sku_name         = "GP_Standard_D2s_v3"
storage_mb       = 65536

backup_retention_days        = 7
geo_redundant_backup_enabled = false
storage_auto_grow_enabled    = true

server_parameters = {
  log_min_duration_statement = "500"
}

tags = {
  env   = "prod"
  app   = "drupal"
  owner = "DI"
}
