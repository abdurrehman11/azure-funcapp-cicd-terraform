resource "azurerm_linux_function_app" "linux_function_app" {
  name                        = var.functionapp_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  service_plan_id             = azurerm_service_plan.service_plan.id
  storage_account_name        = var.storage_account_name
  storage_account_access_key  = data.azurerm_key_vault_secret.storage_access_key.value
  https_only                  = false
  functions_extension_version = "~4"

  app_settings = {
    DOCKER_CUSTOM_IMAGE_NAME            = var.docker_custom_image_name
    FUNCTION_APP_EDIT_MODE              = "readOnly"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  }

  site_config {
    ftps_state                             = "FtpsOnly"
    http2_enabled                          = true
    application_insights_key               = azurerm_application_insights.app_insights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.app_insights.connection_string
    application_stack {
      docker {
        image_name        = var.docker_image_name
        image_tag         = var.docker_image_tag
        registry_url      = data.azurerm_key_vault_secret.docker_registry_server.value
        registry_username = data.azurerm_key_vault_secret.docker_registry_username.value
        registry_password = data.azurerm_key_vault_secret.docker_registry_password.value
      }
    }
  }

  tags = {
    owner = "abdurrehman11"
    group = "TestGroup"
  }

}