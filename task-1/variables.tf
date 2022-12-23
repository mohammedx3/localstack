variable "topic_name" {
  type        = string
  description = "Topic name that will recieve the messages."
  default     = ""
}

variable "sqs_queue" {
  type        = string
  description = "Queue to send and receieve messages."
  default     = ""
}

variable "protocol" {
  type        = string
  description = "Protocol to be used for the messages."
  default     = ""
}

variable "dynamodb_table" {
  type        = string
  description = "Name of the dynamodb table."
  default     = ""
}

variable "billing_mode" {
  type    = string
  default = ""
}

variable "read_capacity" {
  type    = number
}

variable "write_capacity" {
  type    = number
}

variable "hash_key" {
  type    = string
  default = ""
}
