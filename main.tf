terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = var.sub_id
}

data "azurerm_container_registry" "myacr" {
  name = var.acr_name
  resource_group_name = var.rg_name
}

resource "azurerm_container_group" "mycont" {
  name = "my-cont"
  resource_group_name = var.rg_name
  location = var.loc_name
  sku = "Standard"
  os_type = "Linux"
  ip_address_type = "Public"
  dns_name_label = "hello-app"
  container {
    name = "hello-app-cont"
    image = "${data.azurerm_container_registry.myacr.login_server}/${var.image_name}:${var.image_tag}"
    cpu = "1"
    memory = "1.5"
    ports {
      protocol = "TCP"
      port = 5000
    }
  }
  image_registry_credential {
    server = data.azurerm_container_registry.myacr.login_server
    username = data.azurerm_container_registry.myacr.admin_username
    password = data.azurerm_container_registry.myacr.admin_password
  }
}