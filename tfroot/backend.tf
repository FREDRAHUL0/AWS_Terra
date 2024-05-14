terraform {
  backend "s3" {
    bucket = "terras15"
    key    = "terras45/terraform.tfstate"
    region = "ap-south-1"
  }
}
