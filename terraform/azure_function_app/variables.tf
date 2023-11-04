variable "resource_group_name" {
  default = ""
}

variable "location" {
  default = ""
}

variable "key_vault_name" {
  default = ""
}

variable "functionapp_name" {
  description = "Azure Function App Name"
  type        = string
}

variable "functionapp_websites_port" {
  default = "7860"
}

variable "contqainer_start_time_limit" {
  default = "720"
}

variable "docker_image_name" {
  default = ""
}

variable "docker_image_tag" {
  default = ""
}

variable "docker_custom_image_name" {
  default = "<azure_container_registry_name>.azurecr.io/<docker_image_name>:<image_tag>"
}

variable "storage_account_name" {
  default = ""
}

variable "storage_name" {
  default = ""
}

variable "storage_share_name" {
  default = ""
}

variable "storage_type" {
  default = "AzureBlob"
}

variable "storage_mount_path" {
  default = "/code/data"
}

variable "app_service_plan" {
  description = "Azure Function App Plan Name"
  type        = string
}

variable "service_os_type" {
  default = "Linux"
}

variable "service_sku_name" {
  default = "EP1"
}

variable "app_insight_name" {
  description = "Azure Function App Application Insights Name"
  type        = string
}

variable "app_insights_app_type" {
  default = "web"
}
