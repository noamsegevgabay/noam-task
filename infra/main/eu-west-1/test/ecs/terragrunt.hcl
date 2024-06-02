# ecs/terragrunt.hcl

terraform {
  source = "../../../../../modules/ecs"
}

locals {
  stage          = "test"
  project_name   = "noam-task"
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc-main")
  mock_outputs = {
    vpc_id = "vpc-0b3b3b3b3b3b3b3b3"
    private_subnets = ["subnet-0b3b3b3b3b3b3b3b3", "subnet-0b3b3b3b3b3b3b3b3"]
  }
}

dependency "ecr" {
  config_path = find_in_parent_folders("ecr")
  mock_outputs = {
    repository_urls = {
      "noam-task-test" = "753392824297.dkr.ecr.eu-west-1.amazonaws.com/noam-task-test"
    }
  }
}

dependencies {
  paths = ["../vpc-main", "../ecr"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  region = "eu-west-1"
  stage = local.stage
  project_name = local.project_name
  family = local.project_name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  desired_count = 1
  launch_type = "FARGATE"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets = dependency.vpc.outputs.public_subnets
  container_name = local.project_name
  vpc_id = dependency.vpc.outputs.vpc_id
  max_capacity = 4
  min_capacity = 2
  scale_up_cpu_threshold = 80
  scale_down_cpu_threshold = 30
  container_definitions = [
    {
      name = local.project_name
      image = "${dependency.ecr.outputs.repository_urls["noam-task-test"]}:latest"
      cpu = 256
      memory = 512
      portMappings = [
        {
          containerPort = 80
          hostPort = 80
          protocol = "tcp"
        }
      ]
    }
  ]
}