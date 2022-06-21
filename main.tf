terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.6.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "TFResourceGroup"
    storage_account_name = "terraformstatesapi"
    container_name = "statefiles"
    key = "apitf.tfstate"
    
  }
}

provider "azurerm" {
    features {}
}

variable "IMAGEBUILD" {
  type = string
  default = ""
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
    image = "almcfarlane/weatherapi:${var.IMAGEBUILD}"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
  
}