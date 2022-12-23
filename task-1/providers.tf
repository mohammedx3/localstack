provider "aws" {
  region = "eu-central-1"
  endpoints {
    dynamodb = "http://localhost:4566"
    sns      = "http://localhost:4566"
    sqs      = "http://localhost:4566"
  }
}