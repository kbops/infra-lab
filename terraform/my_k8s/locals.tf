locals {
  name            = "lab-${basename(path.cwd)}"
  cluster_version = "1.31"
  region          = "eu-central-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    Test        = local.name
    Environment = "dev"
    Terraform   = "true"
    Manager     = "Valerii Holubiuk"
  }
}
