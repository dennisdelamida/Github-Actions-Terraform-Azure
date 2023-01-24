resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}

# resource "azurerm_storage_account" "STA" {
#   name                     = var.sname
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
#   tags = {
#     environment = "dev"
#   }
# }
# resource "azurerm_mssql_server" "mtc-sqlserver" {
#   name                         = "mssqlsrver01202023"
#   resource_group_name          = azurerm_resource_group.rg.name
#   location                     = var.location
#   version                      = "12.0"
#   administrator_login          = "adminadmin"
#   administrator_login_password = var.password
#   tags = {
#     environment = "dev"
#   }
# }
# resource "azurerm_mssql_database" "RAEdb" {
#   name         = "RAEdb"
#   server_id    = azurerm_mssql_server.mtc-sqlserver.id
#   collation    = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
# }
# resource "azurerm_mssql_database" "ETRAEdb" {
#   name           = "ETRAEdb"
#   server_id      = azurerm_mssql_server.mtc-sqlserver.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   ledger_enabled = true
# }


resource "azurerm_app_service_plan" "mtc-app-service-plan" {
  name                = "etrae-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "mtc-app-service" {
  name                = "etrae-app-service01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.mtc-app-service-plan.id
  app_settings        = local.env_variables

}
