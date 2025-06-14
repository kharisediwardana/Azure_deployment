terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "kharis" {
  name     = "kharis-resources"
  location = "Southeast Asia"
}

resource "azurerm_service_plan" "kharis" {
  name                = "kharis-appserviceplan"
  location            = azurerm_resource_group.kharis.location
  resource_group_name = azurerm_resource_group.kharis.name

  sku_name = "F1"
  os_type  = "Linux"
}

resource "random_id" "rand" {
  byte_length = 3
}

resource "azurerm_linux_web_app" "portal" {
  name                = "portal-${random_id.rand.hex}"
  location            = azurerm_resource_group.kharis.location
  resource_group_name = azurerm_resource_group.kharis.name
  service_plan_id     = azurerm_service_plan.kharis.id

  site_config {
    # you can leave it empty or put other config if needed
  }
}

