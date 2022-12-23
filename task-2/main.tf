resource "helm_release" "localstack" {
  create_namespace = var.create_namespace
  chart            = var.chart
  name             = var.release_name
  namespace        = var.namespace
  repository       = var.repository
  version          = var.chart_version
}

resource "kubernetes_namespace" "justdice" {
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
            value = "http://localstack.justdice.svc.cluster.local:4566"
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
            value = "http://localstack.justdice.svc.cluster.local:4566"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "dynamodb" {
  metadata {
    name      = "dynamodb"
    namespace = "justdice"
    labels = {
      app = "dynamodb"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "dynamodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "dynamodb"
        }
      }
      spec {

        container {
          image = "aaronshaf/dynamodb-admin"
          name  = "dynamodb"

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
            name  = "DYNAMO_ENDPOINT"
            value = "http://localstack.justdice.svc.cluster.local:4566"
          }
          env {
            name  = "AWS_REGION"
            value = "eu-central-1"
          }
        }
      }
    }
  }
}
