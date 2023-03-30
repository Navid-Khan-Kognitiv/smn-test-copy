resource "azurerm_key_vault" "this_keyvault" {
  name                        = "smn-${var.env}-test"
  location                    = module.this.location
  resource_group_name         = module.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = "5bbed656-4f0a-43a0-bef8-c91aecbe75a3"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}


resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = "5bbed656-4f0a-43a0-bef8-c91aecbe75a3"
  object_id    = module.aks.aks_sp

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

