terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Kognitiv"

    workspaces {
      prefix = "smn-test-"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {
  subscription_id = data.azurerm_client_config.current.subscription_id
}

module "this" {
  source  = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/resource-group"
  version = "0.0.10" # Kognitiv's Terraform Module version to use

  rsg_name     = "smn-test-${var.env}"
  rsg_location = var.location

  rsg_environment_tag = var.env
  rsg_owner_tag       = "Kognitiv"
  rsg_application_tag = "Terraform Cloud"
  rsg_project_tag     = "Terraform Cloud PoC"
}
