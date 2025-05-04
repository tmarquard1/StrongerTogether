# variable "cloudfront_distribution_name" {
#   description = "The name of the CloudFront distribution"
#   type        = string
# }

# variable "s3_origin_bucket" {
#   description = "The name of the S3 bucket to be used as the origin for CloudFront"
#   type        = string
# }

# variable "default_root_object" {
#   description = "The default root object for the CloudFront distribution"
#   type        = string
#   default     = "index.html"
# }

# variable "enabled" {
#   description = "Whether the CloudFront distribution is enabled"
#   type        = bool
#   default     = true
# }

# variable "price_class" {
#   description = "The price class for the CloudFront distribution"
#   type        = string
#   default     = "PriceClass_All"
# }

# variable "viewer_certificate" {
#   description = "The viewer certificate configuration for the CloudFront distribution"
#   type        = map(string)
#   default     = {
#     cloudfront_default_certificate = "true"
#   }
# }

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# variable "bucket_policy" {
#   description = "The bucket policy for the S3 bucket"
#   type        = string
#   default     = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "${aws_cloudfront_origin_access_identity.cdn_identity.iam_arn}"
#       },
#       "Action": "s3:GetObject",
#       "Resource": "${aws_s3_bucket.origin_bucket.arn}/*"
#     }
#   ]
# }
# EOF
# }