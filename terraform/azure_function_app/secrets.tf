data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "docker_registry_server" {
  name         = "docker-registry-server"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "docker_registry_username" {
  name         = "docker-registry-username"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "docker_registry_password" {
  name         = "docker-registry-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "storage_access_key" {
  name         = "storage-access-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
