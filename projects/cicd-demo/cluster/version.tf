terraform {
  required_providers {
    kind = {
      source   = "kyma-incubator/kind"
      version = "0.0.9"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.5.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.3.0"
    }

  }
  required_version = ">=1.0.0"
}


provider "kind" {
}

provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}

provider "helm" {
    kubernetes {
        config_path = pathexpand(var.kind_cluster_config_path)
    }
}
