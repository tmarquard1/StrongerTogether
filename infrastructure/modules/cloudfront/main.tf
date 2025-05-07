resource "aws_s3_bucket" "origin_bucket" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }
  
}

resource "aws_s3_object" "upload_files" {
  for_each = fileset(var.upload_directory, "**/*")

  bucket = aws_s3_bucket.origin_bucket.bucket
  key    = each.value
  source = "${var.upload_directory}/${each.value}"
  etag = filemd5("${var.upload_directory}/${each.value}")
}

resource "aws_s3_bucket_policy" "origin_bucket_policy" {
  bucket = aws_s3_bucket.origin_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowCloudFrontServicePrincipalReadOnly",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.origin_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront:::distribution/${aws_cloudfront_distribution.cdn.id}"
          }
        }
      }
    ]
  })
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "default"
  description                       = "Default Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_function" "redirect_trailing_slash" {
  name    = "redirect-trailing-slash"
  runtime = "cloudfront-js-1.0"

  code = <<-EOF
    function handler(event) {
        var request = event.request;
        var uri = request.uri;

        // If the URI does not end with a trailing slash and is not a file, redirect
        if (!uri.endsWith('/') && !uri.includes('.')) {
            return {
                statusCode: 301,
                statusDescription: 'Moved Permanently',
                headers: {
                    location: { value: uri + '/index.html' }
                }
            };
        }

        return request;
    }
  EOF
}
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.origin_bucket.bucket_regional_domain_name
    origin_id   = "S3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for Next.js app"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "S3Origin"

    viewer_protocol_policy = "redirect-to-https"
    allowed_methods       = ["GET", "HEAD"]
    cached_methods        = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
      headers = ["Content-Type"]
    }

    compress = true

    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.redirect_trailing_slash.arn
    }

  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }
  price_class = "PriceClass_100"
}

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