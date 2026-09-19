terraform {
  backend "s3" {
    bucket       = "YOUR-STATE-BUCKET-NAME"
    key          = "hsbc/dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
