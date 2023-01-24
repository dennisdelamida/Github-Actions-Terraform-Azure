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

//-Daryl-//
resource "azurerm_resource_group" "mapsAccExample" {
  name     = "az-maps-acc"
  location = var.zonename
}

resource "azurerm_maps_account" "maps-acc-example" {
  name                = "az-maps-account"
  resource_group_name = azurerm_resource_group.mapsAccExample.name
  sku_name            = "G2"

  tags = {
    environment = "Test"
  }
}

resource "azurerm_maps_creator" "demo" {
  name            = "maps-creator-demo"
  maps_account_id = azurerm_maps_account.maps-acc-example.id
  location        = azurerm_resource_group.mapsAccExample.location
  storage_units   = 1

  tags = {
    environment = "test"
  }
}



resource "azurerm_storage_account" "storage_account" {
  name                      = "darylstoragedemo99"
  resource_group_name       = azurerm_resource_group.mapsAccExample.name
  location                  = azurerm_resource_group.mapsAccExample.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  # allow_blob_public_access  = true

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1> Hello World , this is Daryl Tejares website that was deployed with Terraform on Azure storage"
}



//-Daryl-//