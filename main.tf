terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.6.0"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "tf_test_api" {
  name = "tfapirg"
  location = "UK South"
}

resource "azurerm_container_group" "tf_container_group" {
  name = "tfapicontainergroup"
  location = azurerm_resource_group.tf_test_api.location
  resource_group_name = azurerm_resource_group.tf_test_api.name
  
  ip_address_type = "Public"
  dns_name_label = "almcfarlaneapp"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "almcfarlane/weatherapi"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
  
}