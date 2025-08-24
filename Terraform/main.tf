####################################################### Locals ###################################################################
locals {
  common_tags = {
    Environment = var.environment
  }
}

######################################################## AWS VPC #################################################################
module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  cidr_block   = var.cidr_block
  subnet_cidrs = var.subnet_cidrs
  project_name = var.project_name
  common_tags  = local.common_tags
}

output "AWS_VPC_ID" {
  value = module.vpc.vpc_id
}

######################################################## AWS ECS #################################################################
module "ecs" {
  source              = "./modules/ecs"
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  ecs_task_subnets    = module.vpc.public_subnet_ids
  project_name        = var.project_name
  container_image_tag = var.container_image_tag
  common_tags         = local.common_tags
}

output "repository_url" {
  value = module.ecs.ecr_repository_url
}

output "service_name" {
  value = module.ecs.ecs_service_name
}