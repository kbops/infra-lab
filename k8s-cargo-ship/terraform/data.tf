data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ecr_repository" "k8s_cargo_ship" {
  name = "cargo-ship"
}
