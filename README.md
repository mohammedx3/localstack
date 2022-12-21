# Localstack

## Description
Goal of this repo is to run localstack and two applications, as well as dynamodb-admin to get some visual feedback if the events get written to the DynamoDB table.
The goal should be done in two ways and that is why there is task-1 and task-2.

## Requirements
|   Version    | Terraform |
|:--:|-----------|
| >= |   1.0.0   |

- Docker-compose.
- an AWS account.
- A running Kubernetes cluster.


### Task-1
Running localstack using docker-compose with the rest of the applications that use localstack's endpoint to connect.
The needed infrastructure is provisioned using Terraform which are:
- A SNS topic with the name justdice-dev-devops-producer-events.
- A SQS queue with the name justdice-dev-devops-consumer-events.
- A subscription from the queue to the topicd.
- A DynamoDb table named justdice-dev-devops-consumer-events with an Id attribute of type string as hash key.

the CLOUD_AWS_DEFAULTS_ENDPOINT environment variable is defined in the producer and consumer application to be able to connect to localstack.

Usage:

1. Initialize terraform

```bash
terraform init
```
    
2. Execute terraform

```bash
terraform apply
```

3. Run docker-compose to get all apps up and running
```bash
docker-compose up -d
```

4. Check logs of the consumer, you should see that the consumer is processing the events from the producer.
```bash
docker logs -f {consumer_container_name}
```

### Task-2
Running localstack on a Kubernetes cluster, using `Helm` to install localstack and dynamodb-admin.
Using terraform to create two deployments, one for the producer and another for the consumer.

Usage:

You need a K8s cluster running whether locally or on the cloud.
For AWS EKS:
```bash
eksctl create cluster --name eksctl-cluster --version 1.20 --region eu-central-1 --nodegroup-name linux-nodes --node-type t3.medium --nodes 3
```

1. Initialize terraform

```bash
terraform init
```
    
2. Execute terraform

```bash
terraform apply
```

3. Once the deployment was finished, validate with kubectl the status of the pods.

```bash
kubectl get pods -n justdice
```

4. You can check visual information from dynamodb-admin by doing a port-forward to it.
```bash
kubectl port-forward svc/dynamodb 8001:80001 -n dynamodb
```
