resource "azurerm_service_plan" "service_plan" {
  name                = var.app_service_plan
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.service_os_type
  sku_name            = var.service_sku_name
}