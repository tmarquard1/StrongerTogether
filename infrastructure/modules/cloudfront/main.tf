resource "aws_s3_bucket" "origin_bucket" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }
}

# resource "aws_s3_bucket_policy" "origin_bucket_policy" {
#   bucket = aws_s3_bucket.origin_bucket.id
#   policy = var.bucket_policy
# }

# resource "aws_cloudfront_origin_access_identity" "cdn_identity" {
#   comment = "Origin Access Identity for CloudFront"
# }

# resource "aws_cloudfront_distribution" "cdn" {
#   origin {
#     domain_name = aws_s3_bucket.origin_bucket.bucket_regional_domain_name
#     origin_id   = "S3Origin"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.cdn_identity.id
#     }
#   }

#   enabled             = true
#   default_root_object = "index.html"

#   default_cache_behavior {
#     target_origin_id = "S3Origin"

#     viewer_protocol_policy = "redirect-to-https"
#     allowed_methods       = ["GET", "HEAD"]
#     cached_methods        = ["GET", "HEAD"]

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl     = 0
#     default_ttl = 86400
#     max_ttl     = 31536000
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   tags = {
#     Name = var.cloudfront_distribution_name
#   }
# }

output "bucket_name" {
  value = aws_s3_bucket.origin_bucket.bucket
}

# output "bucket_arn" {
#   value = aws_s3_bucket.origin_bucket.arn
# }

# output "cloudfront_distribution_id" {
#   value = aws_cloudfront_distribution.cdn.id
# }

# output "cloudfront_domain_name" {
#   value = aws_cloudfront_distribution.cdn.domain_name
# }