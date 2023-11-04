terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = "test/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  environment_name = "test"
  application_name = "testapp"
}

module "azure_function_app" {
  source = "../azure_function_app"

  functionapp_name = "app-${local.application_name}-${local.environment_name}"
  app_service_plan = "plan-${local.environment_name}-cv-${local.application_name}"
  app_insight_name = "insights-${local.environment_name}-cv-${local.application_name}"
}
