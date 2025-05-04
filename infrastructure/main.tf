provider "aws" {
  region = var.region
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.s3_bucket_name
}

# module "cloudfront" {
#   source = "./modules/cloudfront"

#   origin_id   = module.s3.bucket_id
#   domain_name = module.s3.bucket_domain_name
# }

# output "cloudfront_distribution_id" {
#   value = module.cloudfront.distribution_id
# }

# output "cloudfront_domain_name" {
#   value = module.cloudfront.domain_name
# }

output "s3_bucket_name" {
  value = module.s3.bucket_name
}
