terraform {
  backend "s3" {
    dynamodb_table = "terra-lock"
    bucket = "terras4"
    key    = "terras45/terraform.tfstate"
    region = "ap-south-1"
  }
}
