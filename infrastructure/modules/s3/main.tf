resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}