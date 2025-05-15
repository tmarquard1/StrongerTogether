
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "upload_directory" {
  description = "The directory where files will be uploaded"
  type        = string
  default     = "../web_client/out"
  
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}
