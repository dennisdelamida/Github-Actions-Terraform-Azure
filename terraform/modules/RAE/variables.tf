variable "sname" {
  type = string
}
variable "location" {
  type = string
}
variable "rgname" {
  type = string
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