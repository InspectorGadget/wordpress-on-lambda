terraform {
  backend "s3" {
    bucket = "wordpress-on-aws-lambda-state"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}
