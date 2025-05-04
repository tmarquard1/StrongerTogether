# output "cloudfront_distribution_id" {
#   value = module.cloudfront.distribution_id
# }

# output "cloudfront_domain_name" {
#   value = module.cloudfront.domain_name
# }

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}