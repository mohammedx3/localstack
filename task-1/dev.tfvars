topic_name     = "justdice-dev-devops-producer-events"
sqs_queue      = "justdice-dev-devops-consumer-events"
protocol       = "sqs"
dynamodb_table = "justdice-dev-devops-consumer-events"
billing_mode   = "PROVISIONED"
read_capacity  = 20
write_capacity = 20
hash_key       = "Id"