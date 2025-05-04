# S3 Module

This module is responsible for creating an Amazon S3 bucket that will serve as the origin for a CloudFront distribution. 

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "s3" {
  source = "../modules/s3"

  # Add your variable assignments here
}
```

## Inputs

| Name          | Description                          | Type   | Default | Required |
|---------------|--------------------------------------|--------|---------|:--------:|
| bucket_name   | The name of the S3 bucket            | string |         |   yes    |
| acl           | The canned ACL to apply to the bucket| string | private |   no     |
| versioning    | Enable versioning on the bucket      | bool   | false   |   no     |

## Outputs

| Name          | Description                          |
|---------------|--------------------------------------|
| bucket_name   | The name of the created S3 bucket    |
| bucket_arn    | The ARN of the created S3 bucket     |