resource "helm_release" "localstack" {
  create_namespace = var.create_namespace
  chart            = var.chart
  name             = var.release_name
  namespace        = var.namespace
  repository       = var.repository
  version          = var.chart_version
}

resource "helm_release" "dynamodb-admin" {
  create_namespace = var.create_namespace
  chart            = "dynamodb"
  name             = "dynamodb"
  namespace        = "dynamodb"
  repository       = "https://keyporttech.github.io/helm-charts/"
  version          = "0.1.27"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "justdice"
  }
}

resource "kubernetes_deployment" "producer" {
  metadata {
    name      = "producer"
    namespace = "justdice"
    labels = {
      app = "producer"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "producer"
      }
    }

    template {
      metadata {
        labels = {
          app = "producer"
        }
      }
      spec {

        container {
          image = "ghcr.io/justdice/devopstest-producer:latest"
          name  = "producer"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          env {
            name  = "DX_AUTO_CREATE"
            value = "true"
          }
          env {
            name  = "CLOUD_AWS_DEFAULTS_ENDPOINT"
            value = "localstack.justdice.svc.cluster.local"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "consumer" {
  metadata {
    name      = "consumer"
    namespace = "justdice"
    labels = {
      app = "consumer"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "consumer"
        }
      }
      spec {

        container {
          image = "ghcr.io/justdice/devopstest-consumer:latest"
          name  = "consumer"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          env {
            name  = "DX_AUTO_CREATE"
            value = "true"
          }
          env {
            name  = "CLOUD_AWS_DEFAULTS_ENDPOINT"
            value = "localstack.justdice.svc.cluster.local"
          }
        }
      }
    }
  }
}
