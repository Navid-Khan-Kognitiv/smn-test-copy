locals {
  postgres_db_list = ["pulse", "access_manger"]
}

# PL - Private DNS Zone
resource "azurerm_private_dns_zone" "this" {
  name                = "${var.project_name}.postgres.database.azure.com"
  resource_group_name = module.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = module.vnet.name
  resource_group_name   = module.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = module.vnet.id
}

#azure postgres
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = "${var.project_name}-${var.env}-psql"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  administrator_login    = "psql"
  administrator_password = var.admin_password

  sku_name                     = "GP_Standard_D4s_v3"
  delegated_subnet_id          = module.db_subnet.subnet_id
  private_dns_zone_id          = azurerm_private_dns_zone.this.id
  backup_retention_days        = "7"
  geo_redundant_backup_enabled = false

  version = "13" # To support v14 needs to upgrade azurerm to >v3.15.0
  zone    = "1"

  storage_mb = "65536"

#   high_availability {
#     mode = "ZoneRedundant"
#     standby_availability_zone = ["2"]
#   }

  maintenance_window {
    day_of_week  = 6
    start_hour   = 0
    start_minute = 30
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  count = try(length(local.postgres_db_list), 0)

  name      = local.postgres_db_list[count.index]
  server_id = azurerm_postgresql_flexible_server.postgres.id
  charset   = "UTF8"
  collation = "English_United States.1252"
}
