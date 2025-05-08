# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }

#   required_version = ">= 1.0.0"
# }

provider "aws" {
  region = var.region
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name = var.s3_bucket_name
  # origin_id   = module.s3.bucket_id
  # domain_name = module.s3.bucket_domain_name
}

# output "cloudfront_distribution_id" {
#   value = module.cloudfront.distribution_id
# }

# output "cloudfront_domain_name" {
#   value = module.cloudfront.domain_name
# }