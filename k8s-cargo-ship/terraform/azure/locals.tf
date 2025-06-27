locals {
  name            = "lab-${basename(path.cwd)}"
  cluster_version = "1.33"
  region          = "eastus"

  tags = {
    Test        = local.name
    Environment = "dev"
    Terraform   = "true"
    Manager     = "Valerii Holubiuk"
  }
}
