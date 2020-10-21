# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "app_service" {
  name                = "challenge-app-service-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = "" # Path to registry server...
    DOCKER_REGISTRY_SERVER_USERNAME = "" # Auth
    DOCKER_REGISTRY_SERVER_PASSWORD = "" # Auth
    */
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|myhost/myrepo:gitcommithash"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}