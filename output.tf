output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.pg.fqdn
}

output "postgres_server_id" {
  value = azurerm_postgresql_flexible_server.pg.id
}

output "pg_subnet_id" {
  value = azurerm_subnet.pgflex.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.pg.id
}
