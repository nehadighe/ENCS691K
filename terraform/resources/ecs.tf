# An ECR repository is a private alternative to Docker Hub.
resource "aws_ecr_repository" "encs691k" {
  name = "encs691_repository"
}

# # We need a cluster in which to put our service.
resource "aws_ecs_cluster" "encs691_cluster" {
  name = "encs691_cluster"
}

# # Log groups hold logs from our app.
resource "aws_cloudwatch_log_group" "encs691k" {
  name = "/ecs/encs691/auctionsystem"
}

# # The main service.
resource "aws_ecs_service" "encs691k" {
  name            = "encs691_auction_system"
  task_definition = aws_ecs_task_definition.encs691k.arn
  cluster         = aws_ecs_cluster.encs691_cluster.id
  launch_type     = "FARGATE"

  desired_count = 1

  load_balancer {
    target_group_arn = "${module.target-group.target-arn}"
    container_name   = "encs691k"
    container_port   = "8081"
  }

  network_configuration {
    assign_public_ip = false

    security_groups = "${split(",", data.terraform_remote_state.security.outputs.node-security-group)}"

    subnets = [
      "${element(element(data.terraform_remote_state.vpc.outputs.pri-subnet-id-a, 1),0)}",
      "${element(element(data.terraform_remote_state.vpc.outputs.pri-subnet-id-b, 1),0)}"
    ]
  }

  # tags = {
  #   Name          = "encs691_ecs_service"
  #   Template      = "encs_691k"
  #   Environment   = "${terraform.workspace}"
  #   Application   = "auction_system"
  #   Purpose       = "ECS service to hold the tasks from the application layer"
  #   Creation_Date = "October_13_2020"
  # }
}

# The task definition for our app.
resource "aws_ecs_task_definition" "encs691k" {
  family = "encs691_auction_system"

  container_definitions = <<EOF
  [
    {
      "name": "encs691k",
      "image": "${aws_ecr_repository.encs691k.repository_url}:latest",
      "portMappings": [
        {
          "containerPort": 8081
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "us-east-1",
          "awslogs-group": "/ecs/encs691/auctionsystem",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]

EOF

  execution_role_arn = aws_iam_role.encs691k-api-task-execution-role.arn

  # These are the minimum values for Fargate containers.
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]

  # This is required for Fargate containers (more on this later).
  network_mode = "awsvpc"
}

# This is the role under which ECS will execute our task. This role becomes more important
# as we add integrations with other AWS services later on.

# The assume_role_policy field works with the following aws_iam_policy_document to allow
# ECS tasks to assume this role we're creating.
resource "aws_iam_role" "encs691k-api-task-execution-role" {
  name               = "encs691k-api-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-task-assume-role.json
}

data "aws_iam_policy_document" "ecs-task-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Normally we'd prefer not to hardcode an ARN in our Terraform, but since this is an AWS-managed
# policy, it's okay.
data "aws_iam_policy" "ecs-task-execution-role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Attach the above policy to the execution role.
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role" {
  role       = aws_iam_role.encs691k-api-task-execution-role.name
  policy_arn = data.aws_iam_policy.ecs-task-execution-role.arn
}