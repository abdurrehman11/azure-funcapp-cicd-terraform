resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insight_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.app_insights_app_type
}
