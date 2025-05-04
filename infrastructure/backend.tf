terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "terraform/state"
    region         = "your-region"
  }
}