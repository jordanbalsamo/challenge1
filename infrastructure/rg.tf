# Create a new Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "challenge-infra-${var.environment}"
  location = var.location
}
