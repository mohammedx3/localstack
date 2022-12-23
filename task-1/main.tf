resource "aws_sns_topic" "user_updates" {
  name = var.topic_name
}

resource "aws_sqs_queue" "user_updates_queue" {
  name = var.sqs_queue
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = var.protocol
  endpoint  = aws_sqs_queue.user_updates_queue.arn
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamodb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }
}
