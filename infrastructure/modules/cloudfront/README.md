# CloudFront Module

This module sets up an Amazon CloudFront distribution with an S3 bucket as the origin. It allows for customization of various settings related to the CloudFront distribution.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "cloudfront" {
  source = "../modules/cloudfront"

  # Add your variable values here
}
```

## Inputs

| Name              | Description                                   | Type   | Default | Required |
|-------------------|-----------------------------------------------|--------|---------|:--------:|
| `s3_bucket_name`  | The name of the S3 bucket to use as origin.  | string | n/a     |   yes    |
| `enabled`         | Whether the CloudFront distribution is enabled. | bool  | true    |    no    |
| `default_ttl`     | Default TTL for cached objects.               | number | 86400   |    no    |
| `max_ttl`         | Maximum TTL for cached objects.               | number | 31536000|    no    |
| `min_ttl`         | Minimum TTL for cached objects.               | number | 0       |    no    |

## Outputs

| Name                  | Description                                   |
|-----------------------|-----------------------------------------------|
| `cloudfront_id`       | The ID of the CloudFront distribution.       |
| `cloudfront_domain`   | The domain name of the CloudFront distribution.|

## Example

Here is an example of how to call this module:

```hcl
module "cloudfront" {
  source = "../modules/cloudfront"

  s3_bucket_name = module.s3.bucket_name
}
```

## Notes

- Ensure that the S3 bucket is created before deploying the CloudFront distribution.
- Review the AWS documentation for more details on CloudFront settings and configurations.