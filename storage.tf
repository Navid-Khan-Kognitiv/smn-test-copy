module "storage_account" {
  source          = "app.terraform.io/Kognitiv/platform-infrastructure-modules/azure//terraform/modules/azure/storage-account"
  version         = "0.0.10"
  release_version = "1" # Kognitiv's Terraform Module version to use

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location # Ex: North Europe
  location_short      = var.location_short   # Ex: neu

  client_name = "PUL"   # Ex: EEC
  environment = var.env # Ex: dev

  allow_public_access = false # Enable or disable public access to the objects inside the SA (default: false) 

  replication_type = "GRS" # Configures the Storage Account replication (default: LRS)

  access_tier = "Hot" # For configuring Hot or Cool access tier (default: Hot)

  containers = ["containera", "container-b"] # List with container names (optional)

  shares = { # List with file shares to be created (optional)
    "sharea" = {
      "quota" = "10"
    },
    "share-b" = {
      "quota" = "15"
    },
  }

  global_common_tags         = local.global_common_tags
  subscription_common_tags   = local.subscription_common_tags
  environment_common_tags    = local.environment_common_tags
  resource_group_common_tags = local.resource_group_common_tags
  role_common_tags           = local.role_common_tags
}


