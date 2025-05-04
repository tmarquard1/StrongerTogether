variable "region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "us-east-1"
}

# variable "cloudfront_enabled" {
#   description = "Enable or disable CloudFront distribution."
#   type        = bool
#   default     = true
# }

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}