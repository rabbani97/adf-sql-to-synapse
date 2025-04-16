# Azure Data Factory: SQL to Synapse Project

This project implements a data movement solution from Azure SQL Database to Azure Synapse Analytics using Azure Data Factory with GitHub integration for source control and CI/CD.

## Architecture

- Source: Azure SQL Database
- Integration: Azure Data Factory
- Staging: Azure Blob Storage
- Destination: Azure Synapse Analytics
- Version Control: GitHub
- CI/CD: GitHub Actions

## Components

- Linked Services: Connections to Azure SQL DB, Synapse, and Blob Storage
- Datasets: Source and target data definitions
- Pipeline: Data copy activity with PolyBase loading