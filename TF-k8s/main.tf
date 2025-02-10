provider "kubernetes" {
  config_path = "~/.kube/config"
}

terraform {
  backend "s3" {
    bucket = "matulo-cka-tf-state"
    ## set the key value as the env i.e. dev, uat, stg, prd etc..
    key    = "k8s/terraform.tfstate"
    region = "eu-south-2"
  }
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-namespace"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
        }
      }
    }
  }
}
