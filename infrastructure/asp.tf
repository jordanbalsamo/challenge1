# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "asp" {
  name                = "challenge-asp-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  # Required for Docker
  kind = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}