resource "azurerm_key_vault" "this_keyvault" {
  name                        = "${var.project_name}-${var.env}-test"
  location                    = module.resource_group.location
  resource_group_name         = module.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

data "azurerm_user_assigned_identity" "this" {
  name                = "${var.project_name}-${var.env}-aks-identity"
  resource_group_name = module.resource_group.name
}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_user_assigned_identity.this.principal_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

