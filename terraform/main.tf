# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure SQL Server
resource "azurerm_mssql_server" "source_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
}

# Allow Azure services to access the SQL Server
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.source_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Source SQL Database
resource "azurerm_mssql_database" "source_db" {
  name         = var.sql_db_name
  server_id    = azurerm_mssql_server.source_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  sku_name     = "Basic"
}

# Storage Account for Synapse
resource "azurerm_storage_account" "synapse_storage" {
  name                     = var.synapse_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
}

# File System for Synapse
resource "azurerm_storage_data_lake_gen2_filesystem" "synapse_fs" {
  name               = "synapsefs"
  storage_account_id = azurerm_storage_account.synapse_storage.id
}

# Synapse Workspace
resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.synapse_fs.id
  sql_administrator_login              = var.sql_admin_username
  sql_administrator_login_password     = var.sql_admin_password

  identity {
    type = "SystemAssigned"
  }
}

# Synapse SQL Pool
resource "azurerm_synapse_sql_pool" "sql_pool" {
  name                 = var.synapse_sql_pool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  storage_account_type = "LRS"
  
  # Add this to prevent potential geo-backup related errors
  geo_backup_policy_enabled = false
  
  # Add explicit dependency to ensure workspace is fully provisioned
  depends_on = [
    azurerm_synapse_workspace.synapse
  ]
  
  # Set a longer timeout as SQL pool creation can take time
  timeouts {
    create = "60m"
    delete = "60m"
  }
}

# Storage Account for ADF Staging
resource "azurerm_storage_account" "staging_storage" {
  name                     = var.staging_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

# Container for ADF Staging
resource "azurerm_storage_container" "staging_container" {
  name                  = "staging"
  storage_account_name  = azurerm_storage_account.staging_storage.name
  container_access_type = "private"
}

# Azure Data Factory
resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}