variable "repository" {
  type        = string
  description = "The repository where we fetch the helm chart."
  default     = "https://localstack.github.io/helm-charts"
}

variable "chart" {
  description = "Name of the chart to install using helm."
  type        = string
  default     = "localstack"
}

variable "chart_version" {
  description = "Chart version of the helm application."
  type        = string
  default     = "0.5.2"
}

variable "release_name" {
  description = "Name of the installed application."
  type        = string
  default     = "localstack"
}

variable "create_namespace" {
  description = "Whether to create the namespace in which the chart will be installed."
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Namespace of which the application will be installed."
  type        = string
  default     = "justdice"
}

variable "kubernetes_config_path" {
  description = "Path to Kubernetes config."
  type        = string
  default     = "~/.kube/config"
}
