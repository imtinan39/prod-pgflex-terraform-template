/* ============ EXISTING RESOURCE GROUP ============ */
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

/* ============ EXISTING VNET ============ */
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

/* ============ CREATE DELEGATED SUBNET ============ */
resource "azurerm_subnet" "pgflex" {
  name                 = var.pg_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.pg_subnet_prefixes

  delegation {
    name = "pgflex-delegation"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

/* ============ CREATE PRIVATE DNS ZONE ============ */
resource "azurerm_private_dns_zone" "pg" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

/* ============ LINK DNS ZONE TO EXISTING VNET ============ */
resource "azurerm_private_dns_zone_virtual_network_link" "pg_link" {
  name                  = "${var.vnet_name}-pgflex-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pg.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = false
  tags                  = var.tags
}

/* ============ CREATE POSTGRES FLEXIBLE SERVER (PRIVATE) ============ */
resource "azurerm_postgresql_flexible_server" "pg" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  version    = var.postgres_version
  sku_name   = var.sku_name
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  storage_auto_grow_enabled    = var.storage_auto_grow_enabled

  zone = var.zone

  public_network_access_enabled = false
  delegated_subnet_id           = azurerm_subnet.pgflex.id
  private_dns_zone_id           = azurerm_private_dns_zone.pg.id

  tags = var.tags

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.pg_link
  ]
lifecycle {
    prevent_destroy = true
  }
}

/* ============ SERVER PARAMETERS (OPTIONAL) ============ */
resource "azurerm_postgresql_flexible_server_configuration" "params" {
  for_each  = var.server_parameters
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.pg.id
  value     = each.value
}
