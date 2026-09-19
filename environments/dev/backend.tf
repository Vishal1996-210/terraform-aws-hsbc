terraform {
  backend "s3" {
    bucket = "hsbc-terraform-state-2026-vishal" //There is just one value that must be changed before you run terraform init. Replace with the exact bucket name you configured in bootstrap/terraform.tfvars.

    key = "hsbc/prod/terraform.tfstate"

    region = "ap-south-1"

    use_lockfile = true

    encrypt = true
  }
}
