resource "azurerm_postgresql_server" "db" {
  name                = var.db_name
  location            = var.location
  resource_group_name = var.rg_name

  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  backup_retention_days = 7
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password
  version             = "11"
  ssl_enforcement_enabled = true
  tags = var.tags
}

resource "azurerm_postgresql_database" "db" {
  name                = "${var.db_name}-db"
  resource_group_name = var.rg_name
  server_name         = azurerm_postgresql_server.db.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
