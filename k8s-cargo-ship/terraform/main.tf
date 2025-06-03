provider "aws" {
  region = local.region
}

module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  cluster_name                             = local.name
  cluster_version                          = "1.32"
  cluster_endpoint_public_access           = true
  cluster_endpoint_public_access_cidrs     = ["195.66.79.218/32"]
  enable_cluster_creator_admin_permissions = true
  subnet_ids                               = module.vpc.private_subnets
  vpc_id                                   = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 3
      min_size       = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Manager     = "Valerii Holubiuk"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  name    = "eks-vpc"
  cidr    = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = local.tags
}

resource "aws_ecr_repository" "cargo_ship" {
  name = "cargo-ship"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "cargo-ship"
    Environment = "dev"
  }
}
