output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "sql_server_name" {
  value = azurerm_mssql_server.source_server.name
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.source_server.fully_qualified_domain_name
}

output "sql_database_name" {
  value = azurerm_mssql_database.source_db.name
}

output "synapse_workspace_name" {
  value = azurerm_synapse_workspace.synapse.name
}

output "synapse_sql_pool_name" {
  value = azurerm_synapse_sql_pool.sql_pool.name
}

output "synapse_sql_endpoint" {
  value = "${azurerm_synapse_workspace.synapse.name}.sql.azuresynapse.net"
}

output "synapse_storage_account_name" {
  value = azurerm_storage_account.synapse_storage.name
}

output "staging_storage_account_name" {
  value = azurerm_storage_account.staging_storage.name
}

output "data_factory_name" {
  value = azurerm_data_factory.adf.name
}