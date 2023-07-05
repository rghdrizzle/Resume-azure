terraform {
    cloud {
    organization = "rghdrizzle"

    workspaces {
      name = "azureresume"
    }
  }
  required_providers {
    
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.63.0"
    }
  }
}
variable "rgname" {}
variable "rglocation" {}
variable "AzureResumeConnectionString" {}

provider "azurerm" {
    features {}
}

resource "azurerm_storage_account" "functionsa" {
  name                     = "azureresume8b31"
  resource_group_name      = var.rgname
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  default_to_oauth_authentication   = true
  account_kind        = "Storage"
}

resource "azurerm_service_plan" "functionserviceplan" {
  name                = "ASP-azureresume-8d92"
  resource_group_name      = var.rgname
  location                 = "eastus"
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function" {
  name                = "resumecounterazure"
  resource_group_name = var.rgname
  location            = "eastus"

  storage_account_name       = azurerm_storage_account.functionsa.name
  storage_account_access_key = azurerm_storage_account.functionsa.primary_access_key
  service_plan_id            = azurerm_service_plan.functionserviceplan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
    cors {
            allowed_origins     = ["https://www.luqmaanrgh.me",] 
            support_credentials = true
            }
  }
  app_settings = {
    "AzureResumeConnectionString"= var.AzureResumeConnectionString
  }

}


