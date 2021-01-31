variable "db_password" {
  description = "The password for the database"
  type        = string
  default     = "password01"
}

variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "shpratee-terraform-state"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "shpratee-terraform-locks"
}
