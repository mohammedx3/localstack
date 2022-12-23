resource "aws_sns_topic" "user_updates" {
  name = "justdice-dev-devops-producer-events"
}

resource "aws_sqs_queue" "user_updates_queue" {
  name = "justdice-dev-devops-consumer-events"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.user_updates_queue.arn
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "justdice-dev-devops-consumer-events"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
}
