resource "azurerm_role_assignment" "aks_cluster_reader" {
  scope                = azurerm_key_vault.this_keyvault.id
  role_definition_name = "Reader"
  principal_id         = module.aks.aks_sp
}

