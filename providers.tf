provider "azurerm" {
  features {}
}

variable "env" {
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "product" {
  description = "The name of the application"
}

variable "common_tags" {
  type = map(string)
}
