# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.33.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      #version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.12.0"

  #backend
backend "remote" {
  organization = "Glitcher255_tf"

  workspaces { 
    name = "Terraform_Kubernetes_Keycloak"
  }
}
}

#Microsoft Azure provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


#Get kubeconfig data
# provider "kubernetes" {
#   host                   = module.vm.kube_config.host
#   client_certificate     = base64decode(module.vm.kube_config.client_certificate)
#   client_key             = base64decode(module.vm.kube_config.client_key)
#   cluster_ca_certificate = base64decode(module.vm.kube_config.cluster_ca_certificate)
#   #config_path = "~/.kube/config"
# }

# provider "helm" {
#   kubernetes = {
#       host                   = module.vm.kube_config.host
#   client_certificate     = base64decode(module.vm.kube_config.client_certificate)
#   client_key             = base64decode(module.vm.kube_config.client_key)
#   cluster_ca_certificate = base64decode(module.vm.kube_config.cluster_ca_certificate)
#   }
# }