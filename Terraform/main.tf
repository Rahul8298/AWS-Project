####################################################### Locals ###################################################################
locals {
  common_tags = {
    Environment = var.environment
  }
}

######################################################## AWS VPC #################################################################
module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  subnet_cidrs         = var.subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
  common_tags          = local.common_tags
}

output "AWS_VPC_ID" {
  value = module.vpc.vpc_id
}

######################################################## AWS ECS #################################################################
module "ecs" {
  source              = "./modules/ecs"
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  ecs_task_subnets    = module.vpc.private_subnet_ids
  ecs_allowed_cidrs   = module.vpc.vpc_cidr_block
  project_name        = var.project_name
  container_image_tag = var.container_image_tag
  alb_tg_arn          = module.elb.target_group_arn
  common_tags         = local.common_tags
}

output "repository_url" {
  value = module.ecs.ecr_repository_url
}

output "service_name" {
  value = module.ecs.ecs_service_name
}

######################################################## AWS ELB #################################################################
module "elb" {
  source       = "./modules/elb"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnet_ids
  project_name = var.project_name
  common_tags  = local.common_tags
}

output "loadbalancer_dns" {
  value = module.elb.alb_dns_name
}