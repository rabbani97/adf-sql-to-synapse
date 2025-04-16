variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "data-integration-rg"
}

variable "location" {
  description = "Azure location for all resources"
  default     = "East US"
}

variable "sql_server_name" {
  description = "Name of the Azure SQL Server"
  default     = "adf-source-server"
}

variable "sql_db_name" {
  description = "Name of the Azure SQL Database"
  default     = "SalesDB"
}

variable "sql_admin_username" {
  description = "Username for SQL Server administrator"
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Password for SQL Server administrator"
  sensitive   = true
}

variable "synapse_workspace_name" {
  description = "Name of the Azure Synapse Analytics workspace"
  default     = "adf-target-synapse"
}

variable "synapse_sql_pool_name" {
  description = "Name of the dedicated SQL pool"
  default     = "SalesPool"
}

variable "synapse_storage_account_name" {
  description = "Name of the storage account for Synapse"
  default     = "adftargetsynhr2023"  # Using your initials and year
}

variable "staging_storage_account_name" {
  description = "Name of the blob storage account for staging"
  default     = "adfstaginghr2023"    # Using your initials and year
}

variable "data_factory_name" {
  description = "Name of the Azure Data Factory"
  default     = "sql-to-synapse-adf"
}