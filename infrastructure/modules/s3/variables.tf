variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply to the bucket."
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning on the bucket."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}