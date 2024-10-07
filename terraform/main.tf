terraform {
  #   cloud {
  #   organization = "rghdrizzle"

  #   workspaces {
  #     name = "azureresumenew"
  #   }
  # }
  required_providers {
    
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.110.0"
    }
  }
}
# variable "rgname" {}
# variable "rglocation" {}
variable "AzureResumeConnectionString" {}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
  name = "ResumeAzure"
  location = "eastus"
}

resource "azurerm_storage_account" "functionsa" {
  name                     = "resumeazuresa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  default_to_oauth_authentication   = true
  account_kind        = "Storage"
}
resource "azurerm_storage_account" "websa" {
  name                     = "resumeazureweb"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind        = "StorageV2"
  cross_tenant_replication_enabled  = false
  default_to_oauth_authentication   = false
  allow_nested_items_to_be_public   = false
   static_website {
      index_document = "index.html"
    }
}

resource "azurerm_service_plan" "functionserviceplan" {
  name                = "ASP-azureresume-plan"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "canadacentral"
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function" {
  name                = "resumecounterazurenew"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "canadacentral"

  storage_account_name       = azurerm_storage_account.functionsa.name
  storage_account_access_key = azurerm_storage_account.functionsa.primary_access_key
  service_plan_id            = azurerm_service_plan.functionserviceplan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
    cors {
            allowed_origins     = ["*"] 
            support_credentials = false
            }
  }
  app_settings = {
    "AzureResumeConnectionString"= var.AzureResumeConnectionString
  }

}
resource "azurerm_cosmosdb_account" "db" {
  name                = "resumeazurecounterdb"
  location            = "centralus"
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"


  automatic_failover_enabled = true

  capabilities {
    name = "EnableServerless"
  }

  capabilities {
    name = "EnableTable"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 86400
    max_staleness_prefix    = 1000000
  }

  geo_location {
    location          = "centralus"
    failover_priority = 0
  }

}

# resource "azurerm_cosmosdb_table" "table" {
#   name                = ""
#   resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
#   account_name        = azurerm_cosmosdb_account.db.name
#   throughput          = 400
# }