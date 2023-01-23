variable "rgname" {
  description = "Resource Group Name"
  default     = "github-action"
  type        = string
}
variable "location" {
  description = "Azure location"
  default     = "East US"
  type        = string
}
variable "sname" {
  description = "Azure Storage Account"
  type        = string
}
variable "password" {
  description = "Azure  password"
  type        = string
}
locals {
  env_variables = {
    DOCKER_REGISTRY_SERVER_URL      = "https://smplacr.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = "smplACR"
    DOCKER_REGISTRY_SERVER_PASSWORD = "FjRBwuSo9Bsy36lOdO7Liv8et4D8A15Oo/JcrPVc79+ACRB5fbmG"
  }
}
